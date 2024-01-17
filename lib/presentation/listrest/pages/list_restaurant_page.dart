import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/presentation/listrest/widgets/list_card.dart';
import 'package:flutter_dicoding_restaurant/presentation/listrest/widgets/no_internet.dart';


import '../../search/pages/search_page.dart';
import '../bloc/list/list_bloc.dart';

class ListRestaurantPage extends StatefulWidget {
  const ListRestaurantPage({super.key});

  @override
  State<ListRestaurantPage> createState() => _ListRestaurantPageState();
}

class _ListRestaurantPageState extends State<ListRestaurantPage> {
  final searchController = TextEditingController();

  Future<void> _onRefresh() async {
    context.read<ListBloc>().add(const ListEvent.fetch());
    searchController.clear();
  }

  @override
  void initState() {
    context.read<ListBloc>().add(const ListEvent.fetch());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 100,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                ),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(10.0),
                title: Text('Restaurant'),
              ),
            ),
            
            SliverToBoxAdapter(
              child: BlocBuilder<ListBloc, ListState>(
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
                    return const NoInternet();
                  }, success: (restaurants) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return ListCard(restaurants: restaurants[index]);
                          },
                        ),
                      ],
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
