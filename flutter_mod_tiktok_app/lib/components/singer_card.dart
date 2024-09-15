import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';

import '../utils/util.dart';

class SingerCard extends StatelessWidget {
  final String coverPictureUrl;
  final String nickname;
  final int musicCount;
  final int musicPlayCount;
  const SingerCard(
      {super.key,
      required this.coverPictureUrl,
      required this.nickname,
      required this.musicCount,
      required this.musicPlayCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            nickname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.active,
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children: [
            _iconText(
              'assets/images/icons/read.png',
              '歌曲:',
              musicCount,
            ),
            _iconText(
              'assets/images/icons/read.png',
              '播放:',
              musicPlayCount,
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconText(String icon, String label, int count) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          Expanded(
            child: Text(
              label + formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.unactive,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
