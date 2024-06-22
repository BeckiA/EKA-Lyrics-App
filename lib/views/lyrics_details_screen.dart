import 'package:eka_lyrics/models/lyrics.dart';
import 'package:flutter/material.dart';

class LyricsDetailScreen extends StatelessWidget {
  final Lyrics lyrics;

  const LyricsDetailScreen({super.key, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lyrics.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            lyrics.lyrics,
            style: const TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
