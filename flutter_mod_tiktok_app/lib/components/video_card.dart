import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/article_card.dart';
import 'package:flutter_mod_tiktok_app/components/avatar_role_name.dart';
import 'package:flutter_mod_tiktok_app/components/comment_like_read.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';
import 'package:flutter_mod_tiktok_app/models/video_model.dart';

class VideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const VideoCard({super.key, required this.videoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(height: 20),
          _cover(),
          SizedBox(height: 20),
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

  Widget _cover() {}

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
}
