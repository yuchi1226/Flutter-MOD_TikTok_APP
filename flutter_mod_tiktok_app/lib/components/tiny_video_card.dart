import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/avatar_role_name.dart';
import 'package:flutter_mod_tiktok_app/components/comment_like_read.dart';
import 'package:flutter_mod_tiktok_app/models/video_model.dart';

class TinyVideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const TinyVideoCard({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _cover(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AvataRoleName(
            coverPictureUrl: videoItem.user!.coverPictureUrl,
            nickname: videoItem.user!.nickname,
            type: videoItem.user!.type,
            //avatarSize: 25,
          ),
        ),
        CommentLikeRead(
          commentCount: videoItem.commentCount,
          thumbUpCount: videoItem.thumbUpCount,
          readCount: videoItem.readCount,
        ),
      ],
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-3.png',
              image: videoItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: 38,
              height: 38,
            ),
          ),
        ],
      ),
    );
  }
}
