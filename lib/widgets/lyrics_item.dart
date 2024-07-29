import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import 'package:eka_lyrics/views/lyrics_details_screen.dart';
import 'package:flutter/material.dart';

class LyricsListItem extends StatelessWidget {
  final int index;
  final Lyrics lyrics;

  const LyricsListItem({super.key, required this.index, required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LyricsDetailScreen(lyrics: lyrics),
          ),
        );
      },
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: ekaAccentColor, // Light blue for container background
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${index + 1}. ${lyrics.title}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ekaTextColor, // Main text color
            ),
          ),
        ),
      ),
    );
  }
}
