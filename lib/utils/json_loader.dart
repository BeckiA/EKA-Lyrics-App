import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lyrics.dart';

Future<List<Lyrics>> loadLyrics() async {
  final String response = await rootBundle.loadString('assets/lyrics_data.json');
  final data = await json.decode(response) as List;
  return data.map((json) => Lyrics.fromJson(json)).toList();
}
