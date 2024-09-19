import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/root_page_head.dart';
import 'package:flutter_mod_tiktok_app/view/sub_pages/singer_page.dart';
import 'package:flutter_mod_tiktok_app/view/sub_pages/song_page..dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

const List<Tab> _tabs = [
  Tab(text: '歌曲'),
  Tab(text: '歌手'),
];

final List<Widget> _tabsContent = [
  const SongPage(),
  const SingerPage(),
];

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      //initialIndex: 1, //起始畫面在第幾頁面
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const RootPageHead(),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          //isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabsContent,
      ),
    );
  }
}
