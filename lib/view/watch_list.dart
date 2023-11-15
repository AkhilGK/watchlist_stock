import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/sql_helper.dart';
import 'package:share_watchlist/model/watctlist_item.dart';
import 'package:share_watchlist/view/widgets/watchlist_tile.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color.fromARGB(192, 51, 201, 46),
          centerTitle: true,
          title: const Text(
            'Watch List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [titleCard('Company'), titleCard('Share Price')],
              ),
              Consumer<WatchListProvider>(
                builder: (context, model, child) {
                  List<Watchlistmodel> result = model.watchList;
                  if (result.isEmpty) {
                    return const SizedBox(
                        height: 200,
                        child: Text('No company added to watch list'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: WatchlistTile(
                                companyDetails: result[index], index: index));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Card titleCard(String title) {
    return Card(
      surfaceTintColor: const Color.fromARGB(255, 35, 42, 138),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 26, 66, 29)),
        ),
      ),
    );
  }
}
