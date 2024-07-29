import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/utils/favorites_provider.dart';
import 'package:eka_lyrics/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const LyricsApp(),
    ),
  );
}

class LyricsApp extends StatelessWidget {
  const LyricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      theme: ThemeData(
        scaffoldBackgroundColor: ekaPrimaryColor, // Set your desired color here
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
