import 'package:flutter/material.dart';
import 'package:share_watchlist/model/company_model.dart';

class SearchResult extends ChangeNotifier {
  List<CompanyModel> searchResult = [];

  void addResult(List<CompanyModel> result) {
    searchResult = result;
    notifyListeners();
  }

  void clearResults() {
    searchResult = [];
    notifyListeners();
  }
}
