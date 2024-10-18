import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../common/router.dart';
import '../bloc/podcast_bloc.dart';
import '../widgets/search_podcast_widget.dart';
// final result = await searchPodcast('EdTech Shorts');

class PodcastScreen extends StatelessWidget {
  const PodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SearchPodcastWidget(),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<PodcastBloc, PodcastState>(builder: (context, state) {
              if (state is PodcastLoading) {
                return const CircularProgressIndicator();
              } else if (state is PodcastLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.podcasts.items?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: (){
                            context.push(episodesRoute);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  state.podcasts.items?[index].title.toString() ?? '',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      state.podcasts.items![index].feedImage.toString(),
                                      height: 80,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                        Bidi.stripHtmlIfNeeded(state.podcasts.items?[index].description.toString() ?? ''),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is PodcastError) {
                return const Text('Failed to fetch subtitles');
              } else {
                return const Text('Start Searching ');
              }
            }),
          ],
        ),
      ),
    );
  }
}