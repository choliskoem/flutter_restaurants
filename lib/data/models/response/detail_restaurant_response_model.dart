import 'dart:convert';

import 'package:flutter_dicoding_restaurant/data/models/response/catategory.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/custom_review.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/menu.dart';

class DetailRestaurantResponseModel {
  final bool error;
  final String message;
  final Restaurant restaurant;

  DetailRestaurantResponseModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantResponseModel.fromJson(String str) =>
      DetailRestaurantResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailRestaurantResponseModel.fromMap(Map<String, dynamic> json) {
    return DetailRestaurantResponseModel(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromMap(json["restaurant"]),
    );
  }
  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toMap(),
      };
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menu menu;
  final double rating;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menu,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
        menu: Menu.fromMap(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
        "menus": menu.toMap(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toMap())),
      };
}




