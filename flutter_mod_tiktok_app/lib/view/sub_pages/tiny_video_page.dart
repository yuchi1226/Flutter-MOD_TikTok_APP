import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/tiny_video_card.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '../../models/video_model.dart';

class TinyVideoPage extends StatefulWidget {
  const TinyVideoPage({super.key});

  @override
  State<TinyVideoPage> createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();

    _getVideos();
  }

  Future _getVideos({bool replace = true}) async {
    try {
      // Fetch the songs collection from Firestore
      CollectionReference TinyVideoCollection =
          FirebaseFirestore.instance.collection('VideoItem');
      // Get the data from Firestore
      QuerySnapshot querySnapshot = await TinyVideoCollection.get();

      print('fetching VideoItem: ');

      // Convert the Firestore documents to a list of maps
      List<dynamic> TinyVideoDataList =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Convert the list of maps into a SongList
      VideoList VideoListModel = VideoList.fromJson(TinyVideoDataList);
      // Update the state with the new song list
      setState(() {
        _videoList = VideoListModel.list;
      });
      // Print out the song list to confirm data is correctly fetched
      print(VideoListModel);
      print('fetching finish ');

      setState(() {
        hasMore = page * limit < 10;
        page++;

        if (replace) {
          _videoList = VideoListModel.list;
        } else {
          _videoList.addAll(VideoListModel.list);
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
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
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
      itemCount: _videoList.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isEven = index.isEven;
        final double pr = isEven ? 10 : 20;
        final double pl = isEven ? 20 : 10;

        return Container(
          padding: EdgeInsets.only(top: 20, left: pl, right: pr),
          color: Colors.white,
          child: TinyVideoCard(videoItem: _videoList[index]),
        );
      },
      padding: const EdgeInsets.only(
        top: 8,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
        childAspectRatio: 9 / 18,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
