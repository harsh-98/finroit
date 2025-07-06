import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/redux/user.dart';
import '../utils/bigtext.dart';
import 'dart:developer';
import '../redux/market.dart';

class TradeCard extends ConsumerStatefulWidget {
  final Market details;
  // var current = WordPair.random();
  const TradeCard({super.key, required this.details});
  @override
  ConsumerState<TradeCard> createState() => _CardState();
}

// This card will have a container and will have three rows: - The title of the asset - A slider - Two columns. In each column, there will be a small text field where it will show the current price. Under it, there will be an elevated button which will show 'Buy' on the left-hand column and 'Sell' on the right-hand column.
class _CardState extends ConsumerState<TradeCard> {
  double amountToTrade = 0;
  double minAmount = 0;
  TextEditingController amountController = TextEditingController(
    text: '0',
  ); // = (text: amountToTrade.toStringAsFixed(3))

  @override
  void initState() {
    super.initState();
    setState(() {
      amountController.text = widget.details
          .getAssetAmount(10)
          .toStringAsFixed(widget.details.assetPrecision);
      minAmount = widget.details.getAssetAmount(10);
      amountToTrade = minAmount;
      // amountController = TextEditingController(
      //   text: amountToTrade.toStringAsFixed(4),
      // );
      final x = widget.details.getAssetAmount(1000);
      log("Min Amount: $minAmount $x ");
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 300,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: bigText(
                widget.details.assetName,
                Theme.of(context).colorScheme.shadow,
              ),
            ),
            Column(
              children: [
                Container(
                  child: TextField(
                    controller: amountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,3}'),
                      ),
                      // FilteringTetInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      // labelText: '$amountToTrade',
                      isCollapsed: true,
                      border: OutlineInputBorder(),
                      hintText: '0',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 5,
                      ),
                    ),
                    // readOnly: true,
                  ),
                  padding: const EdgeInsets.all(10),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Slider(
                      max: widget.details.getAssetAmount(
                        ref.watch(userStateProvider).balance,
                      ),
                      value: amountToTrade,
                      min: minAmount,
                      divisions: null,
                      // label: '${amountToTrade.toStringAsFixed(4)}',
                      onChanged: (value) {
                        setState(() {
                          amountToTrade = value;
                          amountController.text = amountToTrade.toStringAsFixed(
                            widget.details.assetPrecision,
                          );
                          log(amountToTrade.toString());
                          print(amountController.text);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTradeCardColumn(context, widget.details.askPrice, 'Buy'),
                buildTradeCardColumn(context, widget.details.bidPrice, 'Sell'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TradeColumnDetails {
  String title;
  String buttonText;
  TradeColumnDetails({required this.title, required this.buttonText});
}

Widget buildTradeCardColumn(BuildContext context, double price, String action) {
  return Column(
    children: [
      // Text(details.title),
      // Expanded(
      //   child:
      // ),
      Text("${price}\$"),
      // Container(
      //   height: 20,
      //   // flex: 2,
      //   // fit: FlexFit.loose,
      //   child: TextField(
      //     decoration: InputDecoration(
      //       border: OutlineInputBorder(),
      //       hintText: 'Enter Sell Price',
      //     ),
      //     readOnly: true,
      //   ),
      // ),
      ElevatedButton(
        onPressed: () {
          // Add sell logic here
        },
        child: Text(action),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            action == 'Buy'
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    ],
  );
}
