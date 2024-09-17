import 'package:flutter/material.dart';
import '../../components/root_page_head.dart';
import '../sub_pages/singer_page.dart';
import '../sub_pages/song_page..dart';
import '../sub_pages/tiny_video_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<Tab> _tabs = [
  Tab(text: '歌曲'),
  Tab(text: '推薦'),
  Tab(text: '歌手'),
  Tab(text: '短片'),
  Tab(text: '文章'),
  Tab(text: '影片'),
];

final List<Widget> _tabsContent = [
  const SongPage(),
  const Text('111111'),
  const SingerPage(),
  const TinyVideoPage(),
  const Text('111111'),
  const Text('111111'),
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      //initialIndex: 1, //起始畫面在第幾頁面
      length: _tabs.length,
      vsync: this,
    );
    //監聽切換
    //_tabController.addListener(() {
    //  _tabController.index;
    //});
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
