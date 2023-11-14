class CompanyModel {
  String symbol;
  String name;
  String region;
  String type;
  CompanyModel(
      {required this.symbol,
      required this.name,
      required this.region,
      required this.type});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        symbol: json['1. symbol'] ?? '',
        name: json['2. name'] ?? '',
        region: json['4. region'] ?? '',
        type: json['3. type'] ?? '');
  }
  factory CompanyModel.fromDb(Map<String, dynamic> data) {
    return CompanyModel(
        symbol: data['symbol'] ?? '',
        name: data['name'] ?? '',
        region: data['region'] ?? '',
        type: data['type'] ?? '');
  }
}
