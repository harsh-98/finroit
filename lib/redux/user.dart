import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finroit/redux/const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
part 'user.g.dart';

@riverpod
class UserState extends _$UserState {
  String name;
  String userEmail;
  double balance  ;
  int XP ;
  String category;
  String level;
  UserState({ this.name= 'John Doe', 
   this.userEmail = 'ad@gmail.com',
   this.balance = 1000.0,
   this.XP =0,
   this.level = 'LV0',
  this.category = 'L1'});


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
  UserState build()  => UserState();

  update() async {
    log('Updating user state');
    UserState x =  await fetchUserData(Constants.backendApiUrl);
    state = x;
  }
Future<UserState> fetchUserData(String baseUrl) async {
 final response = await http.get(
      Uri.parse('${baseUrl}/user/info'),
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
}
