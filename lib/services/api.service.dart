import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yourstyle/models/offer.dart';

class ApiService {
  static const String _baseUrl = 'http://server.getoutfit.ru/';

  static Future<List<Offer>> getProductList({
    int from = 0,
    String search = '',
    String category = '',
    String lowerPrice = '',
    String upperPrice = '',
  }) async {
    final response = await http.get("${_baseUrl}offers?from=$from&limit=20&currencyId=RUB&name=$search&categoryId=$category&price_above=$lowerPrice&price_below=$upperPrice");

    if (response.statusCode == 200) {
      return List<dynamic>
        .from(json.decode(response.body))
        .map((offer) => Offer.fromJson(offer)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }

  static Future<List<Category>> getCaregoryList() async {
    final response = await http.get("${_baseUrl}categories?limit=100");

    if (response.statusCode == 200) {
      return List<dynamic>
        .from(json.decode(response.body))
        .map((offer) => Category.fromJson(offer)).toList();
    } else {
      throw Exception('Failed to load offers');
    }
  }

  static Future<PriceRange> getPriceRange() async {
    final response = await http.get("${_baseUrl}prices");

    if (response.statusCode == 200) {
      return PriceRange.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load offers');
    }
  }
}