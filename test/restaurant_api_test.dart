import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/list_restaurant_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([http.Client])
void main() {
  group(
    'Testing Restaurant Api',
    () {
      test('if http call complete success return list of restaurant', () async {
        final client = MockClient((request) async {
          final response = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": []
          };
          return Response(json.encode(response), 200);
        });
        expect(
          await RestaurantRemoteDatasource(client).getList(),
          isA<Right<String, ListRestaurantsResponseModel>>(),
        );
      });
    },
  );
}