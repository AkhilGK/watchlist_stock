import 'package:share_watchlist/model/company_model.dart';

class Result {
  List<CompanyModel> bestMatches;
  Result({required this.bestMatches});

  factory Result.fromJson(Map<String, dynamic> json) {
    var matchesList = json['bestMatches'] as List<dynamic>;
    List<CompanyModel> matches =
        matchesList.map((item) => CompanyModel.fromJson(item)).toList();

    return Result(bestMatches: matches);
  }
}
