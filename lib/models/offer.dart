import 'dart:convert';

class Offer {
  final String name;
  final int price;
  final String vendor;
  final String url;
  final List<String> pictures;
  final String id;

  Offer({
    this.name,
    this.price,
    this.vendor,
    this.url,
    this.pictures,
    this.id,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      name: utf8.decode(json['name'].toString().codeUnits),
      price: json['price'],
      url: utf8.decode(json['url'].toString().codeUnits),
      vendor: utf8.decode(json['vendor'].toString().codeUnits),
      pictures: List<String>.from(json['pictures']).toList(),
      id: utf8.decode(json['id'].toString().codeUnits),
    );
  }
}

class Category {
  final String name;
  final int parentId;
  final int id;

  Category({
    this.name,
    this.parentId,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: utf8.decode(json['name'].toString().codeUnits),
      parentId: json['parentId'],
      id: json['id'],
    );
  }
}

class PriceRange {
  final int price_min;
  final int price_max;

  PriceRange({
    this.price_min,
    this.price_max,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      price_min: json['price_min'],
      price_max: json['price_max'],
    );
  }
}