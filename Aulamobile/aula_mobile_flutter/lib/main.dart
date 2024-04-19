import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinGecko API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BitcoinPricePage(),
    );
  }
}

class BitcoinPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Price'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BitcoinPriceScreen()),
            );
          },
          child: Text('Buscar preço do bitcoin'),
        ),
      ),
    );
  }
}

class BitcoinPriceScreen extends StatefulWidget {
  @override
  _BitcoinPriceScreenState createState() => _BitcoinPriceScreenState();
}

class _BitcoinPriceScreenState extends State<BitcoinPriceScreen> {
  String _price = 'carregando...';

  Future<void> _getBitcoinPrice() async {
    final response = await http.get(
      Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _price = '\$${data["bitcoin"]["usd"].toString()}';
      });
    } else {
      setState(() {
        _price = 'Error: Falha ao pegar preço do bitcoin';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Price'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Preço Bitocin:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              _price,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBitcoinPrice,
              child: Text('Atualizar preço'),
            ),
          ],
        ),
      ),
    );
  }
}
