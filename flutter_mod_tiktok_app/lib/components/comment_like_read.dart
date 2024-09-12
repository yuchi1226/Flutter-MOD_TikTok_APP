import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';

import '../utils/util.dart';

class CommentLikeRead extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  const CommentLikeRead(
      {super.key,
      required this.commentCount,
      required this.thumbUpCount,
      required this.readCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconText('assets/images/icons/comment.png', commentCount),
        _iconText('assets/images/icons/like.png', thumbUpCount),
        _iconText('assets/images/icons/read.png', readCount),
      ],
    );
  }

  Widget _iconText(String icon, int count) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 14,
            height: 14,
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.un3active,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
