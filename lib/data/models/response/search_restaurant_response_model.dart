
import 'dart:convert';

class SearchRestaurantResponseModel {
    final bool error;
    final int founded;
    final List<SearchRestaurant> restaurants;

    SearchRestaurantResponseModel({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory SearchRestaurantResponseModel.fromJson(String str) => SearchRestaurantResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchRestaurantResponseModel.fromMap(Map<String, dynamic> json) => SearchRestaurantResponseModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SearchRestaurant>.from(json["restaurants"].map((x) => SearchRestaurant.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
    };
}

class SearchRestaurant {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;

    SearchRestaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory SearchRestaurant.fromJson(String str) => SearchRestaurant.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchRestaurant.fromMap(Map<String, dynamic> json) => SearchRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
