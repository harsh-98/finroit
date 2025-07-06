
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'nav_bar_index.g.dart';

@riverpod
class NavBarIndex extends _$NavBarIndex {
  int index =0;
  NavBarIndex({this.index = 0});
  @override
  NavBarIndex build() =>  NavBarIndex();

  setIndex(int i) {
    state = NavBarIndex(index: i);
  }
}