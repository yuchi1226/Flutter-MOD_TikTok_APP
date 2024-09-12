import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';

class AvataRoleName extends StatelessWidget {
  final String coverPictureUrl;
  final String nickname;
  final String? type;
  final bool showType;

  const AvataRoleName({
    super.key,
    required this.coverPictureUrl,
    required this.nickname,
    this.type,
    this.showType = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avatar(),
        Offstage(
          offstage: !showType,
          child: _role(),
        ),
        _nickname(),
      ],
    );
  }

  Widget _avatar() {
    return SizedBox(
      width: 20,
      height: 20,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-1.png',
            image: coverPictureUrl),
      ),
    );
  }

  Widget _role() {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type ?? '未知',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _nickname() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          left: 6,
        ),
        child: Text(
          nickname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.unactive,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
