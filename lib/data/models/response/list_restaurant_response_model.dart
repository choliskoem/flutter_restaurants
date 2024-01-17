import 'dart:convert';

class ListRestaurantsResponseModel {
  final bool error;
  final String message;
  final int count;
  final List<Restaurants> restaurants;

  ListRestaurantsResponseModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

    factory ListRestaurantsResponseModel.fromJson(Map<String, dynamic> json) =>
      ListRestaurantsResponseModel(
        error: json['error'],
        message: json['message'] ?? "",
        count: json['count'] ?? 0,
        restaurants: json['restaurants'] == null
            ? []
            : List<Restaurants>.from(
                json['restaurants'].map(
                  (x) => Restaurants.fromJson(x),
                ),
              ),
      );
  String toJson() => json.encode(toMap());

  factory ListRestaurantsResponseModel.fromMap(Map<String, dynamic> json) =>
      ListRestaurantsResponseModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurants>.from(
            json["restaurants"].map((x) => Restaurants.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}

class Restaurants {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurants.fromJson(String str) =>
      Restaurants.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurants.fromMap(Map<String, dynamic> json) => Restaurants(
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

  Restaurants copyWith(
      {String? id,
      String? name,
      String? description,
      String? pictureId,
      String? city,
      double? rating}) {
    return Restaurants(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating);
  }
}
