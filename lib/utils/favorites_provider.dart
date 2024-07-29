import 'package:flutter/material.dart';
import 'package:eka_lyrics/models/lyrics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesProvider with ChangeNotifier {
  List<Lyrics> _favorites = [];

  FavoritesProvider() {
    _loadFavorites();
  }

  List<Lyrics> get favorites => _favorites;

  bool isFavorite(Lyrics lyrics) {
    return _favorites.any((fav) => fav.title == lyrics.title);
  }

  void addFavorite(Lyrics lyrics) {
    if (!isFavorite(lyrics)) {
      _favorites.add(lyrics);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavorite(Lyrics lyrics) {
    _favorites.removeWhere((fav) => fav.title == lyrics.title);
    _saveFavorites();
    notifyListeners();
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList = _favorites.map((lyrics) => json.encode(lyrics.toJson())).toList();
    prefs.setStringList('favorites', favoriteList);
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteList = prefs.getStringList('favorites');
    if (favoriteList != null) {
      _favorites = favoriteList.map((item) => Lyrics.fromJson(json.decode(item))).toList();
      notifyListeners();
    }
  }
}
