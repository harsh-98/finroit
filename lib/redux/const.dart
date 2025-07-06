
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'const.g.dart';
@riverpod
class Constants {
  static const String appName = 'Namer';
  static const String appVersion = '1.0.0';
  static const String backendApiUrl = 'https://api';
  static const String extendedApiBaseUrl = 'https://api.extended.exchange';

  @override
  build() {
    return Constants();
  }
}