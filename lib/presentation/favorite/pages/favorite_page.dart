import 'package:flutter/material.dart';

import '../../../data/datasources/restaurant_local_datasource.dart';
import '../../../data/models/response/list_restaurant_response_model.dart';
import '../../detail/pages/detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final localDataSource = RestaurantLocalDatasource.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Restaurants>>(
        // Fetch the list of restaurants from the local database
        future: localDataSource.getAllRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No restaurants available.');
          } else {
            // Display the list of restaurants using ListView.builder
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final restaurant = snapshot.data![index];
                return Dismissible(
                  key: Key(restaurant.id),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    localDataSource.deleteNote(restaurant.id);
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(id: restaurant.id),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(restaurant.name),
                      subtitle: Text(
                          'City: ${restaurant.city}, Rating: ${restaurant.rating}'),
                      // Add more details or customize the ListTile as needed
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
