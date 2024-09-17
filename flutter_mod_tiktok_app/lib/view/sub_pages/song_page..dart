import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/models/song_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/song_card.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  // 下拉刷新控制器
  //late EasyRefreshController _easyRefreshController;
  // 獨立的捲動視圖 防止tab切換時觸發下拉刷新
  late ScrollController _scrollController;
  List<SongItem> _songList = SongList([]).list;
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
    //_scrollController = ScrollController();

    _getSongs();
  }

  /* @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  } */

  Future _getSongs({bool replace = true}) async {
    try {
      // Fetch the songs collection from Firestore
      CollectionReference songsCollection =
          FirebaseFirestore.instance.collection('SongItem');
      // Get the data from Firestore
      QuerySnapshot querySnapshot = await songsCollection.get();

      print('fetching SongItem: ');

      // Convert the Firestore documents to a list of maps
      List<dynamic> songDataList =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Convert the list of maps into a SongList
      SongList songListModel = SongList.fromJson(songDataList);
      // Update the state with the new song list
      setState(() {
        _songList = songListModel.list;
      });
      // Print out the song list to confirm data is correctly fetched
      print(songListModel);
      print('fetching finish ');

      setState(() {
        hasMore = page * limit < 10;
        page++;

        if (replace) {
          _songList.addAll(songListModel.list);
        } else {
          _songList = songListModel.list;
        }
      });
    } catch (e) {
      print('Error fetching songs: $e');
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    }
  }

  /* Future _getsongs({bool push = false}) async {
    /* try {
      // 獲取歌曲集合
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('SongItem').get();

      // 遍歷每個文檔
      for (var doc in querySnapshot.docs) {
        print(doc.data()); // 打印文檔數據
      }
    } catch (e) {
      print("Error getting songs: $e");
    } */
    try {
      // Fetch the songs collection from Firestore
      CollectionReference songsCollection =
          FirebaseFirestore.instance.collection('SongItem');

      // Get the data from Firestore
      QuerySnapshot querySnapshot = await songsCollection.get();

      // Convert each document into a Map (or to your specific entity class)
      List<Map<String, dynamic>> songs = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Print each song's data
      for (var song in songs) {
        print(song);
      }
    } catch (e) {
      print('Error fetching songs: $e');
    }
  } */

  //31
  /* Future _getsongs_test({bool push = false}) async {
    //獲取數據
    Map<String, dynamic> result = await SongService.getSongs(page: page);
    //將數據轉換為實體數據
    SongList songListModel = SongList.fromJson(result['data']);

    setState(() {
      hasMore = page * limit < result['total'];
      page++;

      if (push) {
        _songList.addAll(songListModel.list);
      } else {
        _songList = songListModel.list;
      }
    });
  } */

  //下拉刷新
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getSongs();
    // 恢復刷新狀態 讓onLoad再次可用
    _easyRefreshController.resetFooter();
  }

  //上拉加載
  Future _onLoad() async {
    try {
      if (hasMore) {
        await _getSongs(replace: false);
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
        itemCount: _songList.length,
        itemBuilder: (BuildContext context, int index) {
          /* return Container(
            height: 80,
            color: Colors.black.withOpacity(index / 10),
          ); */
          return Column(
            children: [
              const SizedBox(height: 8),
              SongCard(songItem: _songList[index]),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
