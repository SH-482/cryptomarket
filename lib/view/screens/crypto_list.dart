import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_view_model.dart';

class CryptoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptocurrency Data'),
      ),
      body:StreamBuilder<List<Cryptocurrency>>(
        stream: homeViewModel.streamCryptocurrencyData(),
        builder: (BuildContext context, AsyncSnapshot<List<Cryptocurrency>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cryptocurrency data available.'));
          } else {
            List<Cryptocurrency> cryptoData = snapshot.data!;
            return ListView.builder(
              itemCount: cryptoData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cryptoData[index].exchange),
                  subtitle: Text(cryptoData[index].pair),
                  trailing: Text(cryptoData[index].active ? 'Active' : 'Inactive'),
                );
              },
            );
          }
        },
      ),
      // body: FutureBuilder<List<Cryptocurrency>>(
      //   future: homeViewModel.fetchCryptocurrencyData().timeout(const Duration(seconds: 10), onTimeout: () {
      //     // This will be run if fetchCryptocurrencyData does not complete in 10 seconds.
      //     throw TimeoutException('fetchCryptocurrencyData took too long to complete.');
      //   }),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No cryptocurrency data available.'));
      //     } else {
      //       List<Cryptocurrency> cryptoData = snapshot.data!;
      //       return ListView.builder(
      //         itemCount: cryptoData.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(cryptoData[index].exchange),
      //             subtitle: Text(cryptoData[index].pair),
      //             trailing: Text(cryptoData[index].active ? 'Active' : 'Inactive'),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
    );
  }
}
