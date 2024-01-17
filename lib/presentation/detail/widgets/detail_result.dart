import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/detail_bloc.dart';

class DetailResult extends StatelessWidget {
  const DetailResult({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const SizedBox();
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, error: (message) {
            return Center(
              child: Text(message),
            );
          }, connection: () {
            return const SizedBox();
          }, success: (restaurant) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        restaurant.city,
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Deskripsi'),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Menu'),
                  const Text(
                    'Foods:',
                    style: TextStyle(fontSize: 12),
                  ),
                  Scrollbar(
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        controller: _scrollController,
                        children: restaurant.menu.foods.map((food) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.food_bank_outlined,
                                    size: 25.0,
                                  ),
                                  Center(
                                    child: Text(
                                      food.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Drinks:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(),
                  Scrollbar(
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GridView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        children: restaurant.menu.drinks.map(
                          (drinks) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.local_drink_outlined,
                                      size: 25.0,
                                    ),
                                    Center(
                                      child: Text(
                                        drinks.name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Reviewer',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(),
                  Scrollbar(
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: restaurant.customerReviews.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(restaurant.customerReviews[index].name),
                            subtitle:
                                Text(restaurant.customerReviews[index].review),
                            trailing:
                                Text(restaurant.customerReviews[index].date),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
