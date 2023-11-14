class Price {
  String price;
  Price({required this.price});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(price: json["Global Quote"]['05. price']);
  }
}
