// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/sql_helper.dart';
import 'package:http/http.dart' as http;
import 'package:share_watchlist/model/watctlist_item.dart';
import '../../controller/constants/constants.dart';
import '../../model/price_model.dart';

class WatchlistTile extends StatelessWidget {
  const WatchlistTile(
      {super.key, required this.companyDetails, required this.index});
  final Watchlistmodel companyDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    WatchListProvider watchList = Provider.of<WatchListProvider>(context);

    return ListTile(
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(companyDetails.symbol),
          FutureBuilder(
              future: getPrice(companyDetails.symbol),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const RefreshProgressIndicator();
                }
                return Text(snapshot.data ?? '');
              })
        ],
      ),
      title: Text(companyDetails.name),
      trailing: IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AlertDialog(
                    title: const Text(
                      'Delete?',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    content: const Text(
                      "Do you want to delete this stock",
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await watchList.deleteItem(companyDetails.id);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Item removed from watchlist"),
                          ));
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(
            Icons.clear_rounded,
            size: 30,
            color: Colors.redAccent,
          )),
    );
  }

  Future<String> getPrice(String symbol) async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Price price = Price.fromJson(data);
        return price.price;
      }
      return 'N/A';
    } catch (err) {
      debugPrint(err.toString());
      return 'N/A';
    }
  }
}
