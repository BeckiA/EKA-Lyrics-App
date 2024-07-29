import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import 'package:eka_lyrics/utils/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class LyricsDetailScreen extends StatelessWidget {
  final Lyrics lyrics;

  const LyricsDetailScreen({super.key, required this.lyrics});

  void _shareLyrics() {
    final String content = "${lyrics.title}\n\n${lyrics.lyrics}";
    Share.share(content);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lyrics.title),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isFavorite(lyrics);
                    return ListTile(
                      leading: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border),
                      title: Text(isFavorite
                          ? 'ከተመረጡ ዝርዝር ውስጥ ያውጡ' : 'ይህን መዝሙር ይውደዱ'),
                    );
                  },
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('ይህን መዝሙር ያጋሩ'),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: ekaPrimaryColor,
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              lyrics.lyrics,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        final favoritesProvider =
            Provider.of<FavoritesProvider>(context, listen: false);
        if (favoritesProvider.isFavorite(lyrics)) {
          favoritesProvider.removeFavorite(lyrics);
        } else {
          favoritesProvider.addFavorite(lyrics);
        }
        break;
      case 1:
        _shareLyrics();
        break;
    }
  }
}
