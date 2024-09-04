import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../utils/util.dart';

class SongCard extends StatelessWidget {
  final SongItem songItem;
  const SongCard({super.key, required this.songItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(toRpx(context, 40)),
      child: Row(
        children: [
          _songCover(),
          //_songContent(),
        ],
      ),
    );
  }

  /* Widget _songContent() {

  } */

  Widget _songCover() {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: songItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/tiny_video.png',
              width: 22,
              height: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
