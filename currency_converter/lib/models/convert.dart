import 'dart:convert';

Convert convertFromJson(String str, String from_currency, String to_currency) =>
    Convert.fromJson(json.decode(str), from_currency, to_currency);

class Convert {
  Convert({
    this.from_to,
  });

  double from_to;

  factory Convert.fromJson(
          Map<String, dynamic> json, from_currency, to_currency) =>
      Convert(
        from_to: json['${from_currency}_${to_currency}'].toDouble(),
      );
}
