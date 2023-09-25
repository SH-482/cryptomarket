import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_view_model.dart';
import 'crypto_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Api Call")),
      body: Center(
        child: Consumer<HomeViewModel>(
          builder: (context, homeViewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    homeViewModel.streamCryptocurrencyData();
                    print(homeViewModel.streamCryptocurrencyData());
                    print(homeViewModel.cryptoservice);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CryptoListScreen()
                      ),
                    );

                  },
                  child: Text('Fetch Market Data'),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
