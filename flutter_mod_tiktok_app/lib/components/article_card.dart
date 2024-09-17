// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/components/avatar_role_name.dart';
import 'package:flutter_mod_tiktok_app/components/comment_like_read.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';
import 'package:flutter_mod_tiktok_app/models/article_model.dart';
import 'package:flutter_mod_tiktok_app/utils/util.dart';

class ArticleCard extends StatefulWidget {
  final ArticleItem articleItem;
  const ArticleCard({super.key, required this.articleItem});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

const double spaceSize = 10;
const double paddingSize = 20;

class _ArticleCardState extends State<ArticleCard> {
  late double boxSize;

  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - paddingSize * 2;
    return Container(
      padding: EdgeInsets.all(paddingSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(height: paddingSize),
          _cover(),
          SizedBox(height: paddingSize),
          _bottom(),
        ],
      ),
    );
  }

// 一張=>1種
// 兩張=>2種
// 三張=>2種+4種
// 四張=>2種+4種+1種
//
// coverType:
// 一張=>1
// 兩張=>2、3
// 三張=>2、3、4、5、6、7
// 四張=>2、3、4、5、6、7、8
// 基於圖片的長度獲取不同的隨機類型
  int _getTypeByLength() {
    int length = widget.articleItem.coverUrlList.length;
    int coverType;
    switch (length) {
      case 2:
        coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        coverType = getRandomRangeInt(2, 7);
        break;
      case 4:
        coverType = getRandomRangeInt(2, 8);
        break;
      default:
        coverType = 1;
    }
    return coverType;
  }

  _getCoverByType() {
    int coverType = _getTypeByLength();
    Widget _coverWidget;

    switch (coverType) {
      case 2:
        _coverWidget = _cover2();
        break;
      default:
        _coverWidget = _cover();
    }

    return _coverWidget;
  }

  //2張
  Widget _cover2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      widget.articleItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.active,
      ),
    );
  }

  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/common/lazy-1.png',
        image: widget.articleItem.coverUrlList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvataRoleName(
            coverPictureUrl: widget.articleItem.user.coverPictureUrl,
            nickname: widget.articleItem.user.nickname,
            type: widget.articleItem.user.type,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: widget.articleItem.commentCount,
            thumbUpCount: widget.articleItem.thumbUpCount,
            readCount: widget.articleItem.readCount,
          ),
        ),
      ],
    );
  }
}
