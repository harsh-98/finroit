import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/redux/market.dart';
import 'package:namer_app/redux/nav_bar_index.dart';
import 'package:namer_app/utils/bigtext.dart';
import 'dart:developer' as dev;

class CategoryTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Consumer(
        builder: (context, ref, child) {
          var categoryIndex = ref.watch(categoryIndexProvider).index;
          var markets = ref.watch(marketsProvider);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: markets.categories.length,
            itemBuilder: (context, index) {
              bool isSelected = index == categoryIndex;
              return Container(
                margin: EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    ref.read(categoryIndexProvider.notifier).setIndex(index);
                    // log("Category tapped: $index");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? Color(0xFF4F46E5) : Color(0xFF1F2937),
                    ),
                    child: Center(child:Text(
                      markets.categories[index],
                      style: textstyle.mid,
                    )),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
