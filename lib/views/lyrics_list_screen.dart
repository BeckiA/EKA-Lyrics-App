import 'package:flutter/material.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import '../utils/json_loader.dart';
import 'lyrics_details_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
      appBar: AppBar(
        title: const Text('Lyrics'),
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

class LyricsListItem extends StatefulWidget {
  final int index;
  final Lyrics lyrics;

  const LyricsListItem({super.key, required this.index, required this.lyrics});

  @override
  State<LyricsListItem> createState() => _LyricsListItemState();
}

class _LyricsListItemState extends State<LyricsListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start off the screen to the right
      end: Offset.zero, // End at the item's default position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('item-${widget.index}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.75) {
          _animationController.forward();
        }
      },
      child: SlideTransition(
        position: _offsetAnimation,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LyricsDetailScreen(lyrics: widget.lyrics),
              ),
            );
          },
          child: Container(
            height: 55,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
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
                "${widget.index + 1}. ${widget.lyrics.title}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
