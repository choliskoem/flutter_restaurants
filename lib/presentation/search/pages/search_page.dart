import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/presentation/listrest/widgets/no_internet.dart';

import 'package:flutter_dicoding_restaurant/presentation/search/bloc/search/search_bloc.dart';

import '../../detail/pages/detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: TextField(
          controller: searchController,
          autofocus: true,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
          ),
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
          onChanged: (value) {
            if (value.length > 3) {
              context.read<SearchBloc>().add(SearchEvent.search(value));
            }
            if (value.isEmpty) {
              context.read<SearchBloc>().add(const SearchEvent.started());
            }
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Center(
                child: Text("Data Belum Ditemukan"),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, error: (message) {
              return Center(
                child: Text(message),
              );
            }, connection: () {
              return const NoInternet();
            }, success: (restaurants) {
              return restaurants.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(id: restaurants[index].id),
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
                                      tag: restaurants[index].pictureId,
                                      child: CachedNetworkImage(
                                        width: 180,
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            'https://restaurant-api.dicoding.dev/images/medium/${restaurants[index].pictureId}',
                                        placeholder: (_, __) =>
                                            const CircularProgressIndicator(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              restaurants[index].name,
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
                                                restaurants[index].city,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star),
                                              Text(
                                                restaurants[index]
                                                    .rating
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Data Belum Ditemukan"),
                    );
            });
          },
        ),
      ),
    );
  }
}
