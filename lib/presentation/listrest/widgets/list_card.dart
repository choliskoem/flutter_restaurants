// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/list_restaurant_response_model.dart';
import 'package:flutter_dicoding_restaurant/presentation/detail/pages/detail_page.dart';

import '../../../data/datasources/restaurant_local_datasource.dart';

class ListCard extends StatefulWidget {
  final Restaurants restaurants;

  const ListCard({
    super.key,
    required this.restaurants,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  final localDataSource = RestaurantLocalDatasource.instance;
  bool isFavorite = false;

  Future<void> checkFavoriteStatus() async {
    final favoriteStatus = await RestaurantLocalDatasource.instance
        .isRestaurantFavorite(widget.restaurants.id);

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  void initState() {
    checkFavoriteStatus();
    super.initState();
  }

  @override
  void dispose() {
    checkFavoriteStatus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(id: widget.restaurants.id),
            ),
          );
        },
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Hero(
                  tag: widget.restaurants.pictureId,
                  child: CachedNetworkImage(
                    width: 180,
                    fit: BoxFit.fill,
                    imageUrl:
                        'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurants.pictureId}',
                    placeholder: (_, __) => const CircularProgressIndicator(),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.restaurant_outlined,
                      size: 80,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.restaurants.name,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                          ),
                          Text(
                            widget.restaurants.city,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          Text(
                            widget.restaurants.rating.toString(),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isFavorite
                              ? const Icon(Icons.favorite)
                              : IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                    final newRestaurant = Restaurants(
                                      id: widget.restaurants.id,
                                      name: widget.restaurants.name,
                                      description: widget.restaurants.city,
                                      pictureId: widget.restaurants.pictureId,
                                      city: widget.restaurants.city,
                                      rating: 4.5,
                                    );

                                    await localDataSource
                                        .insertRestaurant(newRestaurant);

                                  
                                  },
                                  icon: isFavorite
                                      ? const Icon(Icons.favorite)
                                      : const Icon(
                                          Icons.favorite_border_outlined),
                                ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
