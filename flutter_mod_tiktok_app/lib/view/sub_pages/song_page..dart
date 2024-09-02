import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/models/song_model.dart';

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

    //_getsongs();
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
          color: Colors.black.withOpacity(index/10),
        );
      },
    );
  }
}
