// ignore_for_file: avoid_print

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mod_tiktok_app/components/video_card.dart';
import 'package:flutter_mod_tiktok_app/models/video_model.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  // 下拉刷新控制器
  //late EasyRefreshController _easyRefreshController;
  // 獨立的捲動視圖 防止tab切換時觸發下拉刷新
  late ScrollController _scrollController;
  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _scrollController = ScrollController();

    _getVideos();
  }

  /* @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  } */

  Future _getVideos({bool replace = true}) async {
    try {
      // Fetch the songs collection from Firestore
      CollectionReference videosCollection =
          FirebaseFirestore.instance.collection('VideoItem');
      // Get the data from Firestore
      QuerySnapshot querySnapshot = await videosCollection.get();

      print('fetching VideoItem: ');

      // Convert the Firestore documents to a list of maps
      List<dynamic> videoDataList =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Convert the list of maps into a SongList
      VideoList videoListModel = VideoList.fromJson(videoDataList);
      // Update the state with the new song list
      setState(() {
        _videoList = videoListModel.list;
      });
      // Print out the song list to confirm data is correctly fetched
      print(videoListModel);
      print('fetching finish ');

      setState(() {
        hasMore = page * limit < 10;
        page++;

        if (replace) {
          _videoList.addAll(videoListModel.list);
        } else {
          _videoList = videoListModel.list;
        }
      });
    } catch (e) {
      print('Error fetching articles: $e');
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    }
  }

  //下拉刷新
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getVideos();
    // 恢復刷新狀態 讓onLoad再次可用
    _easyRefreshController.resetFooter();
  }

  //上拉加載
  Future _onLoad() async {
    try {
      if (hasMore) {
        await _getVideos(replace: false);
      }
      // 完成加載
      //_easyRefreshController.finishLoad(IndicatorResult.noMore);
      _easyRefreshController.finishLoad(
          hasMore ? IndicatorResult.success : IndicatorResult.noMore);
    } catch (e) {
      print('_onLoad failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: _easyRefreshController,
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      //enableControlFinishRefresh: true,
      //enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        itemCount: _videoList.length,
        itemBuilder: (BuildContext context, int index) {
          /* return Container(
            height: 80,
            color: Colors.black.withOpacity(index / 10),
          ); */
          return Column(
            children: [
              const SizedBox(height: 8),
              VideoCard(videoItem: _videoList[index]),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
