import 'package:flutter/material.dart';
import 'package:namer_app/components/nav_bar.dart';

class TradeAsset extends StatefulWidget {
  const TradeAsset({super.key});
  // var current = WordPair.random();

  @override
  State<TradeAsset> createState() => TradeAssetState();
}

class TradeAssetState extends State<TradeAsset>  {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Trade Asset Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your trade logic here
              },
              child: const Text('Trade Now'),
            ),
          ],
        )
        );
  }
}