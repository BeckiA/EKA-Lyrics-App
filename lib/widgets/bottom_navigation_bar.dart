import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/views/favorite_list_screen.dart';
import 'package:eka_lyrics/views/lyrics_list_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const LyricsListScreen(),
    const FavoritesListScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ekaAccentColor,
          mouseCursor: SystemMouseCursors.grab,
          unselectedIconTheme: const IconThemeData(size: 25),
          selectedFontSize: 18,
          unselectedFontSize: 16,
                    items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'ማውጫ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'የተወደዱ',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
        body: _pages.elementAt(_selectedIndex));
  }
}
