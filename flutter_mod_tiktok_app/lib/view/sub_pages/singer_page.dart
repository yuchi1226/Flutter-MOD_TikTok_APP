import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/singer_card.dart';
import '../../components/song_card.dart';
import '../../models/user_model.dart';

class SingerPage extends StatefulWidget {
  const SingerPage({super.key});

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {
  List<UserItem> _singerList = UserList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getusers();
  }

  Future _getusers({bool replace = true}) async {
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _singerList.length,
      itemBuilder: (BuildContext context, int index) {
        final bool _isEven = index.isEven;
        final double _pr = _isEven ? 10 : 20;
        final double _pl = _isEven ? 20 : 10;

        return Container(
          padding: EdgeInsets.only(top: 20, left: _pl, right: _pr),
          color: Colors.white,
          child: SingerCard(
            coverPictureUrl: _singerList[index].coverPictureUrl,
            nickname: _singerList[index].nickname,
            musicCount: _singerList[index].musicCount,
            musicPlayCount: _singerList[index].musicPlayCount,
          ),
        );
      },
      padding: const EdgeInsets.only(
        top: 8,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: MediaQuery.of(context).size.width / 1.5,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
      ),
    );
  }
}
