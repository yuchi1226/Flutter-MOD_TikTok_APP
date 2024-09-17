import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/singer_card.dart';
import '../../models/user_model.dart';
import 'package:easy_refresh/easy_refresh.dart';

class SingerPage extends StatefulWidget {
  const SingerPage({super.key});

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  List<UserItem> _singerList = UserList([]).list;
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

    _getUsers();
  }

  Future _getUsers({bool replace = true}) async {
    try {
      // Fetch the songs collection from Firestore
      CollectionReference singerCollection =
          FirebaseFirestore.instance.collection('UserItem');
      // Get the data from Firestore
      QuerySnapshot querySnapshot = await singerCollection.get();

      print('fetching UserItem: ');

      // Convert the Firestore documents to a list of maps
      List<dynamic> singerDataList =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Convert the list of maps into a SongList
      UserList singerListModel = UserList.fromJson(singerDataList);
      // Update the state with the new song list
      setState(() {
        _singerList = singerListModel.list;
      });
      // Print out the song list to confirm data is correctly fetched
      print(singerListModel);
      print('fetching finish ');

      setState(() {
        hasMore = page * limit < 10;
        page++;

        if (replace) {
          _singerList = singerListModel.list;
        } else {
          _singerList.addAll(singerListModel.list);
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

  /* Future _getSingers({bool replace = true}) async {
    try {
      Map<String, dynamic> result = await SingerService.getSingers(page: page);
      List<dynamic> singerList = result['list'];
      SingerList singerListModel = SingerList.fromJson(singerList);

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _singerList = singerListModel.list;
        } else {
          _singerList.addAll(singerListModel.list);
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
  } */

  //下拉刷新
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getUsers();
    // 恢復刷新狀態 讓onLoad再次可用
    _easyRefreshController.resetFooter();
  }

  //上拉加載
  Future _onLoad() async {
    try {
      if (hasMore) {
        await _getUsers(replace: false);
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
      itemCount: _singerList.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isEven = index.isEven;
        final double pr = isEven ? 10 : 20;
        final double pl = isEven ? 20 : 10;

        return Container(
          padding: EdgeInsets.only(top: 20, left: pl, right: pr),
          color: Colors.white,
          child: SingerCard(
            coverPictureUrl: _singerList[index].coverPictureUrl,
            nickname: _singerList[index].nickname,
            musicCount: _singerList[index].musicCount,
            musicPlayCount: _singerList[index].musicPlayCount,
          ),
        );
      },
      padding: const EdgeInsets.only(top: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: MediaQuery.of(context).size.width / 1.5,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
