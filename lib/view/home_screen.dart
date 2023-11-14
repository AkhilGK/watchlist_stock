import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/bottomnav_controller.dart';
import 'package:share_watchlist/view/search_screen.dart';
import 'package:share_watchlist/view/watch_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> screens = [const SearchScreen(), const WatchList()];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = Provider.of<BottomnavController>(context).selctedIndex;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded), label: 'Watch List'),
        ],
        onTap: Provider.of<BottomnavController>(context).onChange,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 52, 201, 46),
      ),
    );
  }
}
