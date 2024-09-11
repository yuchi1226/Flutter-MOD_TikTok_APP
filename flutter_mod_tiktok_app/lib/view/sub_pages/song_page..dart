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

    _getsongs();
  }

  Future _getsongs({bool push = false}) async {
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

        if (push) {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _songList.length,
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
