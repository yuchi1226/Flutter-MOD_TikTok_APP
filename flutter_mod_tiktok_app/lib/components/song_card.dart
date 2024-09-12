import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/avatar_role_name.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';
import '../models/song_model.dart';
import '../utils/util.dart';
import 'comment_like_read.dart';

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
          const SizedBox(
            width: 8,
          ), //文字中間加點距離
          _songContent(),
        ],
      ),
    );
  }

  Widget _songContent() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Stack(
          children: [
            Text(
              songItem.cnName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.active,
                fontSize: 16,
              ),
            ),
            Positioned(
              top: 25,
              child: Text(
                songItem.enName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.un3active,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: AvataRoleName(
                      coverPictureUrl: songItem.user.coverPictureUrl,
                      nickname: songItem.user.nickname,
                      showType: false,
                      //type: 'DQ_SINGER',
                    ),
                  ),
                  Expanded(
                    child: CommentLikeRead(
                      commentCount: songItem.commentCount,
                      thumbUpCount: songItem.thumbUpCount,
                      readCount: songItem.readCount,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
