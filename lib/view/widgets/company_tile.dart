import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/sql_helper.dart';
import 'package:share_watchlist/model/company_model.dart';
import 'package:http/http.dart' as http;
import 'package:share_watchlist/model/price_model.dart';

import '../../controller/constants/constants.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({super.key, required this.companyDetails});
  final CompanyModel companyDetails;

  @override
  Widget build(BuildContext context) {
    WatchListProvider watchList = Provider.of<WatchListProvider>(context);

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(companyDetails.symbol),
          FutureBuilder(
              future: getPrice(companyDetails.symbol),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Text(snapshot.data ?? '');
              })
        ],
      ),
      subtitle: Text(companyDetails.name),
      trailing: IconButton(
          onPressed: () async {
            await watchList.addData(companyDetails);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item added successfully"),
            )); // addToWatchlist(context);
          },
          icon: const Icon(
            Icons.add,
            size: 30,
            color: Colors.green,
          )),
    );
  }

  Future<String> getPrice(String symbol) async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey"
          //"https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo"
          ));
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

  // void addToWatchlist(BuildContext context) async {
  //   final int id = await WatchL.addData(companyDetails);
  //   const ScaffoldMessenger(child: Text('Added to watch list'));
  // }
}
