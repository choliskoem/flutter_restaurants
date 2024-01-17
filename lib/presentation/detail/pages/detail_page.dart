import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/presentation/detail/bloc/bloc/detail_bloc.dart';

import '../widgets/detail_result.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<DetailBloc>().add(DetailEvent.fetch(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: BlocBuilder<DetailBloc, DetailState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Text('Tidak Ada Data');
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    connection: () {
                      return Column(
                        children: [
                          SafeArea(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons
                                      .signal_wifi_connected_no_internet_4_rounded,
                                  size: 144.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  'No Internet Connection',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    error: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                    success: (restaurant) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: widget.id,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                              placeholder: (_, __) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (_, __, ___) => const Icon(
                                Icons.restaurant_outlined,
                                size: 80,
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          DetailResult(scrollController: _scrollController),
        ],
      ),
    );
  }
}
