import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class RootPageHead extends StatelessWidget {
  const RootPageHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/common/logo.png',
          height: 40,
        ),
        Expanded(
          child: _searchConent(),
        ),
        Image.asset(
          'assets/images/icons/msg.png',
          height: 30,
        ),
      ],
    );
  }

  Widget _searchConent() {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.page,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 2,),
            child: Icon(
              Icons.search,
              size: 16,
              color: AppColors.un3active,
            ),
          ),
          Text(
            '搜索關鍵詞',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.un3active,
            ),
          ),
        ],
      ),
    );
  }
}
