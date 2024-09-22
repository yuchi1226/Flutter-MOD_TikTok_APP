import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/article_card.dart';
import 'package:flutter_mod_tiktok_app/components/avatar_role_name.dart';
import 'package:flutter_mod_tiktok_app/components/comment_like_read.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';
import 'package:flutter_mod_tiktok_app/models/video_model.dart';
import 'package:flutter_mod_tiktok_app/utils/util.dart';

class VideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const VideoCard({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const SizedBox(height: 20),
          _cover(),
          const SizedBox(height: 20),
          _bottom(),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      videoItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: videoItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                secondsToTime(videoItem.contentSeconds),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvataRoleName(
            coverPictureUrl: videoItem.user.coverPictureUrl,
            nickname: videoItem.user.nickname,
            type: videoItem.user.type,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: videoItem.commentCount,
            thumbUpCount: videoItem.thumbUpCount,
            readCount: videoItem.readCount,
          ),
        ),
      ],
    );
  }
}
