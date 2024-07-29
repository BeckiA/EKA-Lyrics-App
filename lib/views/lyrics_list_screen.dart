import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import 'package:eka_lyrics/widgets/drawer_contents_widget.dart';
import 'package:eka_lyrics/widgets/lyrics_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  List<Lyrics> _allLyrics = [];
  List<Lyrics> _filteredLyrics = [];

  @override
  void initState() {
    super.initState();
    _loadLyrics().then((lyrics) {
      setState(() {
        _allLyrics = lyrics;
        _filteredLyrics = lyrics;
      });
    });
  }

  void _filterLyrics(String query) {
    List<Lyrics> filtered = _allLyrics.where((lyrics) {
      return lyrics.title.contains(query) ||
          lyrics.title.toLowerCase().contains(query.toLowerCase()) ||
          lyrics.title.split(" - ")[0].contains(query);
    }).toList();

    setState(() {
      _filteredLyrics = filtered;
    });
  }

  DateTime? lastPressed;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    bool backButtonPressedOnce = lastPressed != null &&
        now.difference(lastPressed!) <= const Duration(seconds: 2);

    if (backButtonPressedOnce) {
      return true;
    } else {
      lastPressed = DateTime.now();
      _showExitDialog();
      return false;
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('መዝሙር ደብተሩን ይዝጉ'),
          content: const Text('መተግበርያውን መዝጋት ይፈልጋሉ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('አይ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Future.delayed(const Duration(milliseconds: 200), () {
                  SystemNavigator.pop(); // Exit the app
                });
              },
              child: const Text('አዎ!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          drawer: const Drawer(
            child: DrawerContent(),
          ),
          appBar: AppBar(
            title: const Text('መዝሙር ደብተር'),
            backgroundColor: ekaAccentColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: LyricsSearchDelegate(_allLyrics, _filterLyrics),
                  );
                },
              ),
            ],
          ),
          body: _filteredLyrics.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _filteredLyrics.length,
                  itemBuilder: (context, index) {
                    final lyrics = _filteredLyrics[index];
                    return LyricsListItem(index: index, lyrics: lyrics);
                  },
                )
        
      ),
    );
  }
}

class LyricsSearchDelegate extends SearchDelegate {
  final List<Lyrics> lyrics;
  final Function(String) onSearch;

  LyricsSearchDelegate(this.lyrics, this.onSearch);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Lyrics> suggestions = lyrics.where((lyrics) {
      return lyrics.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return GestureDetector(
          onTap: () {
            query = suggestion.title;
            showResults(context);
          },
          child: LyricsListItem(
            index: index,
            lyrics: suggestion,
          ),
        );
      },
    );
  }
}
