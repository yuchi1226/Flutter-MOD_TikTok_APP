import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/models/song_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/song_card.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<SongItem> _songList = SongList([]).list;
  late int page = 1;
  late int limit = 10;
  late bool hasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getsongs();
  }

  Future _getsongs({bool push = false}) async {
    try {
      // 獲取歌曲集合
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('SongItem').get();

      // 遍歷每個文檔
      for (var doc in querySnapshot.docs) {
        print(doc.data()); // 打印文檔數據
      }
    } catch (e) {
      print("Error getting songs: $e");
    }
  }
  //31
  //Future _getsongs({bool push = false}) async {
  // //獲取數據
  // Map<String, dynamic> result = await SongService.getSongs(page: page);
  // //將數據轉換為實體數據
  // SongList songListModel = SongList.fromJson(result['data']);
  //
  // SetState((){
  //  hasMore = page * limit < result['total'];
  //  page++;
  //
  //  if(push) {
  //    _songList.addAll (songListModel.list);
  //  }else {
  //    _songList = songListModel.list;
  //  }
  // });
  //}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 80,
          color: Colors.black.withOpacity(index / 10),
        );
        /* return Column(
          children: [
            SizedBox(
              height: 16,
            ),
            SongCard(songItem: _songList[index]),
          ],
        ); */
      },
    );
  }
}
