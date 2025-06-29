// import 'package:english_words/english_words.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/card_deck.dart';
import 'package:namer_app/redux/state.dart';
import 'package:redux_thunk/redux_thunk.dart';
// import 'package:flutter/rendering.dart';
import 'dart:developer';
import 'routes/home_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'components/card.dart';
import 'routes/trade_asset.dart';
import 'redux/market.dart';
import 'util.dart';
import 'theme.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState(
      markets: Map<String, List<Market>>.from({
        'L1': [
          Market.dummy(), 
          Market.dummy(), 
          Market.dummy(),
          ],
      }),
      userState: UserState(
        userName: 'John Doe',
        userEmail: 'a',
        balance: 1000.0,
      ),
    ),
    middleware: [thunkMiddleware],
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "ADLaM Display", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: brightness == Brightness.light ? theme.dark() : theme.dark(),
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
        initialRoute: '/clan',
        routes: {
          '/': (context) => const HomePage(),
          '/trade': (context) => const TradeAsset(),
          '/user': (context) => const TradeAsset(), // Placeholder for user page
          '/clan': (context) => const Scaffold(
            body: Center(child: CardDeck()),
          ), // Placeholder for clan page
          // '/loading': (context) => const Loading(),
        },
      ),
    );
  }
}
