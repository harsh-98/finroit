// import 'package:english_words/english_words.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:finroit/components/card_deck.dart';
import 'package:finroit/components/nav_bar.dart';
import 'package:finroit/routes/home_page.dart';
import 'package:finroit/routes/leaderboard_page.dart';
import 'package:riverpod/riverpod.dart';
// import 'package:flutter/rendering.dart';
import 'dart:developer';
import 'routes/banner.dart';
import 'components/card.dart';
import 'routes/trade_asset.dart';
import 'redux/market.dart';
import 'util.dart';
import 'theme.dart';
import 'routes/trading_scaffold.dart';
import 'routes/banner.dart' as Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // final Store<AppState> store = Store<AppState>(
  //   appReducer,
  //   initialState: AppState(
  //     markets: Map<String, List<Market>>.from({
  //       'L1': [
  //         Market.dummy(),
  //         Market.dummy(),
  //         Market.dummy(),
  //         ],
  //     }),
  //     userState: UserState(
  //       userName: 'John Doe',
  //       userEmail: 'a',
  //       balance: 1000.0,
  //     ),
  //   ),
  //   middleware: [thunkMiddleware],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
    // TextTheme textTheme = createTextTheme(context, "ADLaM Display", "ABeeZee");
    // MaterialTheme theme = MaterialTheme(textTheme);
    return ProviderScope(
      child: MaterialApp(
        // theme: brightness == Brightness.light ? theme.dark() : theme.dark(),
        // theme:ThemeData(
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: const Color(0xff3A4AEA),
        //     primary: const Color(0xff3A4AEA),
        //     secondary: const Color(0xff8B8AF5),
        //     shadow: const Color(0xff20182C),
        //     error: const Color(0xffE360A7),
        //     secondaryFixed: const Color(0xff47D8D6),
        //   ),
        // ),
        debugShowCheckedModeBanner: false,
        title: 'FinRoit',
        // home: HomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => const Banner.Banner(),
          // '/trade': (context) => const TradeAsset(),
          '/home': (context) => HomePage(), // Placeholder for user page
          '/leaderboard': (context) => const LeaderboardPage(),
          // '/clan': (context) => const Scaffold(
          //   bottomNavigationBar: NavBar(),
          //   body: Center(child: CardDeck()),
          // ), // Placeholder for clan page
          '/trade': (context) => const TradingScaffold(), // Placeholder for test page
          // '/loading': (context) => const Loading(),
        },
      ),
    );
  }
}
