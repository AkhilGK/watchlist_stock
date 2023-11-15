class Watchlistmodel {
  int id;
  String symbol;
  String name;
  String region;
  String type;
  Watchlistmodel(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.region,
      required this.type});

  factory Watchlistmodel.fromDb(Map<String, dynamic> data) {
    return Watchlistmodel(
        id: data['id'],
        symbol: data['symbol'] ?? '',
        name: data['name'] ?? '',
        region: data['region'] ?? '',
        type: data['type'] ?? '');
  }
}
