import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Cryptoservice with ChangeNotifier {
  final String apiKey;
  Cryptoservice({required this.apiKey});

  Stream<List<Map<String, dynamic>>> streamMarketData() async* {
    try {
      while (true) {
        final Uri apiUri = Uri.parse('https://api.cryptowat.ch/markets');
        final response = await http.get(apiUri, headers: {
          'Authorization': 'Bearer $apiKey',
        });
        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body)['result']);
          yield data;
          await Future.delayed(Duration(seconds: 10)); // adjust the delay as needed
        } else {
          throw Exception("Failed to fetch the data ");
        }
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }
}
