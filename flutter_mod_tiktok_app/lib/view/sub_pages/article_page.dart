// ignore_for_file: avoid_print

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/article_card.dart';
import 'package:flutter_mod_tiktok_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  // 下拉刷新控制器
  //late EasyRefreshController _easyRefreshController;
  // 獨立的捲動視圖 防止tab切換時觸發下拉刷新
  late ScrollController _scrollController;
  List<ArticleItem> _articleList = ArticleList([]).list;
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

    _getArticles();
  }

  /* @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  } */

  Future _getArticles({bool replace = true}) async {
    try {
      // Fetch the songs collection from Firestore
      CollectionReference articlesCollection =
          FirebaseFirestore.instance.collection('ArticleItem');
      // Get the data from Firestore
      QuerySnapshot querySnapshot = await articlesCollection.get();

      print('fetching ArticleItem: ');

      // Convert the Firestore documents to a list of maps
      List<dynamic> articleDataList =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Convert the list of maps into a SongList
      ArticleList articleListModel = ArticleList.fromJson(articleDataList);
      // Update the state with the new song list
      setState(() {
        _articleList = articleListModel.list;
      });
      // Print out the song list to confirm data is correctly fetched
      print(articleListModel);
      print('fetching finish ');

      setState(() {
        hasMore = page * limit < 10;
        page++;

        if (replace) {
          _articleList.addAll(articleListModel.list);
        } else {
          _articleList = articleListModel.list;
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
    await _getArticles();
    // 恢復刷新狀態 讓onLoad再次可用
    _easyRefreshController.resetFooter();
  }

  //上拉加載
  Future _onLoad() async {
    try {
      if (hasMore) {
        await _getArticles(replace: false);
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
        itemCount: _articleList.length,
        itemBuilder: (BuildContext context, int index) {
          /* return Container(
            height: 80,
            color: Colors.black.withOpacity(index / 10),
          ); */
          return Column(
            children: [
              const SizedBox(height: 8),
              ArticleCard(articleItem: _articleList[index]),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
