import 'package:eka_lyrics/widgets/lyrics_item.dart';
import 'package:flutter/material.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import '../utils/json_loader.dart';

class LyricsListScreen extends StatefulWidget {
  const LyricsListScreen({super.key});

  @override
  State<LyricsListScreen> createState() => _LyricsListScreenState();
}

class _LyricsListScreenState extends State<LyricsListScreen> {
  Future<List<Lyrics>> _loadLyrics() async {
    return await loadLyrics();
  }

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('መዝሙር ደብተር'),
        backgroundColor: const Color(0xFFffb703), // Primary color

      ),
      body: FutureBuilder<List<Lyrics>>(
        future: _loadLyrics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lyrics available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final lyrics = snapshot.data![index];
                return LyricsListItem(index: index, lyrics: lyrics);
              },
            );
          }
        },
      ),
    );
  }
}

