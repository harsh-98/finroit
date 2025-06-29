import 'dart:math' ;
import 'package:flutter/material.dart';
import 'market.dart';

class UserState {
  String userName;
  String userEmail;
  double balance = 1000 ;
  UserState({required this.userName, required this.userEmail, balance});
}
class AppState {
  final Map<String, List<Market>> markets;
  final UserState userState ;
  final extendedBaseUrl = 'https://api.extended.exchange';
  final category = 'L1' ;

  AppState({required this.markets, required this.userState});

}

class Error {
  final String message;
  Error(this.message);
}
class GetMarketsAction {
  final Map<String, List<Market>> markets;
  GetMarketsAction({required this.markets});
}

AppState appReducer(AppState state, dynamic action) {
  if (action is GetMarketsAction) {
    return AppState(
      markets: action.markets,
      userState: state.userState,
    );
    // return AppState(markets: action.markets, userState: state.userState);
  } else if (action is Error) {
    // Handle error action if needed
    print(action.message);
    return state;
  }
  return state;
}

