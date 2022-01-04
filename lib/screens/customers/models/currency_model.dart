class CurrencyModel {
  CurrencyModel({
    required this.symbol,
    required this.name,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
  });

  String symbol;
  String name;
  String symbolNative;
  int decimalDigits;
  double rounding;
  String code;
  String namePlural;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    symbol: json["symbol"],
    name: json["name"],
    symbolNative: json["symbol_native"],
    decimalDigits: json["decimal_digits"],
    rounding: json["rounding"].toDouble(),
    code: json["code"],
    namePlural: json["name_plural"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "name": name,
    "symbol_native": symbolNative,
    "decimal_digits": decimalDigits,
    "rounding": rounding,
    "code": code,
    "name_plural": namePlural,
  };
}
