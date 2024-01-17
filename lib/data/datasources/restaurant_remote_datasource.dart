import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/search_restaurant_response_model.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

import '../models/response/detail_restaurant_response_model.dart';
import '../models/response/list_restaurant_response_model.dart';

class RestaurantRemoteDatasource {
  final Client client;
  RestaurantRemoteDatasource(this.client);
  Future<Either<String, ListRestaurantsResponseModel>> getList() async {
    final response =
        await client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

    if (response.statusCode == 200) {
      return right(
          ListRestaurantsResponseModel.fromJson(json.decode(response.body)));
    } else {
      return left('Failed to fetch restaurant list. Status code: ${response.statusCode}');
    }
  }

  Future<ListRestaurantsResponseModel> topHeadlines() async {
    final response =
        await client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (response.statusCode == 200) {
      return ListRestaurantsResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ListRestaurantsResponseModel.fromJson(json.decode(response.body))
          .message;
    }
  }

  Future<Either<String, DetailRestaurantResponseModel>> getDetail(
      String id) async {
    final response = await client
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));

    if (response.statusCode == 200) {
      return right(DetailRestaurantResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, SearchRestaurantResponseModel>> search(
      String query) async {
    final response = await client
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

    if (response.statusCode == 200) {
      return right(SearchRestaurantResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
