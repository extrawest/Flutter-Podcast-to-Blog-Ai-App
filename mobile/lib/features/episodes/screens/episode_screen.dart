import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_index_app/features/episodes/widgets/more_widget.dart';

import '../../podcast/models/podcast_model.dart';
import '../widgets/main_content_widget.dart';

class EpisodeScreen extends StatefulWidget {
  final Item item;

  const EpisodeScreen({
    super.key,
    required this.item,
  });

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> with SingleTickerProviderStateMixin {
  late AudioPlayer player = AudioPlayer();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title ?? ''),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(
            text: 'Main Content',
          ),
          Tab(
            text: 'More',
          ),
        ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          MainContentWidget(
            item: widget.item,
          ),
          MoreWidget(item: widget.item),
        ],
      ),
    );
  }
}
