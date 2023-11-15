// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_watchlist/controller/constants/constants.dart';
import 'package:share_watchlist/controller/search_result.dart';
import 'package:share_watchlist/model/company_model.dart';
import 'package:share_watchlist/view/widgets/company_tile.dart';

import '../model/search_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color.fromARGB(192, 51, 201, 46),
        centerTitle: true,
        title: const Text(
          'Trade Brains',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text('Try searching Company name...'),
            const SizedBox(
              height: 10,
            ),
            CupertinoSearchTextField(
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle,
                color: Color.fromARGB(213, 158, 158, 158),
              ),
              style: const TextStyle(color: Colors.black87),
              onChanged: (value) {
                if (value.isEmpty) {
                  // Clear the list when the search field is empty
                  context.read<SearchResult>().clearResults();
                } else {
                  getData(value);
                }
              },
            ),
            isLoading
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Image.asset(
                        'profit_7185066.png',
                        height: 200,
                      ),
                    ),
                  )
                : Expanded(
                    child: Consumer<SearchResult>(
                      builder: (context, searchResult, child) {
                        List<CompanyModel> result = searchResult.searchResult;
                        return ListView.builder(
                          itemCount: result.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: CompanyTile(companyDetails: result[index]),
                            );
                          },
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void getData(String keyWord) async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keyWord&apikey=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);

        Result res = Result.fromJson(data);
        context.read<SearchResult>().addResult(res.bestMatches);
      }
    } catch (err) {
      debugPrint(err.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
