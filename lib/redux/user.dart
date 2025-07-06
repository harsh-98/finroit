import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/redux/const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.g.dart';

@riverpod
class UserState extends _$UserState {
  String name;
  String userEmail;
  double balance  ;
  int XP ;
  String category;
  String level;
  UserState({required this.name, 
  required this.userEmail, 
  required this.balance,
  required this.XP,
  required this.level ,
  this.category = 'L1'});

  static dummy() {
    return UserState(
      name: 'John Doe',
      userEmail: 'ad@gmail.com',
      balance: 1000.0,
      XP: 0,
      level: 'LV8',
    );
  }

  static fromJson(Map<String, dynamic> json) {
    return UserState(
      name: json['name'] as String,
      userEmail: json['userEmail'] as String,
      balance: (json['balance'] as num).toDouble(),
      XP: (json['XP'] as num).toInt(),
      category: json['category'] as String? ?? 'L1',
      level: json['level'] as String,
    );
  }

  @override
  UserState build()  => UserState.dummy();

  Future<void > update(ref) async {
    // UserState x = await ref.read(fetchUserDataProvider);
    // state = UserState.dummy();
  }
}

@riverpod
Future<UserState> fetchUserData(FetchUserDataRef ref) async {
 final response = await http.get(
      Uri.parse('${ref.read(constantsProvider )}/user/info'),
    );
    if (response.statusCode == 200) {
      // Parse the response data
      final dynamic data = jsonDecode(response.body);
        final userState = UserState.fromJson(data as Map<String, dynamic>);
      return userState;
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
}