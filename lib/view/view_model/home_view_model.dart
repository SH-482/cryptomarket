import 'package:flutter/foundation.dart';
import '../../services/crypto_service.dart';

class Cryptocurrency {
  final String exchange;
  final String pair;
  final bool active;

  Cryptocurrency({
    required this.exchange,
    required this.pair,
    required this.active,
  });

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
      exchange: json['exchange'],
      pair: json['pair'],
      active: json['active'],
    );
  }
}

class HomeViewModel with ChangeNotifier {
  Cryptoservice _cryptoservice;

  HomeViewModel({required Cryptoservice cryptoservice}) : _cryptoservice = cryptoservice;

  Cryptoservice get cryptoservice => _cryptoservice;

  set cryptoservice(Cryptoservice value) {
    _cryptoservice = value;
    notifyListeners();
  }

  Stream<List<Cryptocurrency>> streamCryptocurrencyData() async* {
    try {
      await for (var data in _cryptoservice.streamMarketData()) {
        yield data.map((item) => Cryptocurrency.fromJson(item)).toList();
        await Future.delayed(Duration(seconds: 10)); // adjust the delay as needed
      }
    } catch (error) {
      print("Error fetching data: Barista$error");
      throw error;
    }
  }

}
