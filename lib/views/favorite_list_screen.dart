import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/constants/image_strings.dart';
import 'package:eka_lyrics/utils/favorites_provider.dart';
import 'package:eka_lyrics/widgets/bottom_navigation_bar.dart';
import 'package:eka_lyrics/widgets/lyrics_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eka_lyrics/views/lyrics_details_screen.dart';

class FavoritesListScreen extends StatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesListScreenState createState() => _FavoritesListScreenState();
}

class _FavoritesListScreenState extends State<FavoritesListScreen> {
  DateTime? lastPressed;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    bool backButtonPressedOnce = lastPressed != null &&
        now.difference(lastPressed!) <= const Duration(seconds: 2);

    if (backButtonPressedOnce) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
      return true;
    } else {
      lastPressed = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ወደ ማውጫው ለመመለስ በድጋሚ ይጫኑ'),
        ),
      );
      return false;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("የተወደዱ መዝሙሮች"),
          backgroundColor:
              ekaAccentColor, // Replace with your ekaAccentColor if defined
        ),
        body: Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, child) {
            final favorites = favoritesProvider.favorites;
            return favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            ekaNoFavorites), // Replace with your ekaNoFavorites path
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: const Text(
                            "ምንም መዝሙር አልመረጡም ለመምረጥ የ ❤ ምልክቷን ይጫኑ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA6A6A6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final lyrics = favorites[index];
                      return Dismissible(
                        key: ValueKey(favorites),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          favoritesProvider.removeFavorite(lyrics);

                          setState(() {});
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LyricsDetailScreen(lyrics: lyrics),
                              ),
                            );
                          },
                          child: LyricsListItem(index: index, lyrics: lyrics),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
