import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/bottomnav_controller.dart';
import 'package:share_watchlist/controller/search_result.dart';
import 'package:share_watchlist/view/home_screen.dart';

import 'controller/sql_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomnavController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchResult(),
        ),
        ChangeNotifierProvider(
          create: (context) => WatchListProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
