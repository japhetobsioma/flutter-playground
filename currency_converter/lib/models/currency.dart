import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  Currency({
    this.results,
  });

  Map<String, Result> results;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        results: Map.from(json['results'])
            .map((k, v) => MapEntry<String, Result>(k, Result.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        'results': Map.from(results)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Result {
  Result({
    this.alpha3,
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
    this.id,
    this.name,
  });

  String alpha3;
  String currencyId;
  String currencyName;
  String currencySymbol;
  String id;
  String name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        alpha3: json['alpha3'],
        currencyId: json['currencyId'],
        currencyName: json['currencyName'],
        currencySymbol: json['currencySymbol'],
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'alpha3': alpha3,
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
        'id': id,
        'name': name,
      };
}
