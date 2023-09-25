import 'package:flutter/material.dart';
import 'package:new_demo/services/crypto_service.dart';
import 'package:new_demo/view/screens/homescreen.dart';
import 'package:new_demo/view/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String cryptowatchApiKey = '+bIlqC86UeHAlxxYNTWN+FnH6F9rIgiIg7Q2aV2O';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Create a ChangeNotifierProvider for Cryptoservice
        ChangeNotifierProvider<Cryptoservice>(create: (context) => Cryptoservice(apiKey: cryptowatchApiKey)),

        // Create a ChangeNotifierProxyProvider for HomeViewModel
        ChangeNotifierProxyProvider<Cryptoservice, HomeViewModel>(
          create: (context) => HomeViewModel(cryptoservice: context.read<Cryptoservice>()),
          update: (_, cryptoservice, homeViewModel) {
            // Set the cryptoservice for HomeViewModel
            homeViewModel!.cryptoservice = cryptoservice;
            return homeViewModel;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Name',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
