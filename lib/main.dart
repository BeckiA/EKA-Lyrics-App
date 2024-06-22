import 'package:eka_lyrics/views/lyrics_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LyricsApp());
}

class LyricsApp extends StatelessWidget {
  const LyricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LyricsListScreen(),
    );
  }
}
