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
      padding: const EdgeInsets.all(paddingSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          const SizedBox(height: paddingSize),
          _getCoverByType(),
          const SizedBox(height: paddingSize),
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
    //int length = widget.articleItem.coverUrlList.length;
    double length = widget.articleItem.coverUrlList.length / 4 + 1; //只寫了顯示4張圖的，後面在優化成4張以上
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
    //int coverType = 1;
    Widget coverWidget;

    switch (coverType) {
      case 2:
        coverWidget = _cover2();
        break;
      case 3:
        coverWidget = _cover3();
        break;
      case 4:
        coverWidget = _cover4();
        break;
      case 5:
        coverWidget = _cover5();
        break;
      case 6:
        coverWidget = _cover6();
        break;
      case 7:
        coverWidget = _cover7();
        break;
      case 8:
        coverWidget = _cover8();
        break;
      default:
        coverWidget = _cover1();
    }

    return coverWidget;
  }

  /// 1張->1
  Widget _cover1() {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: _cover(index: 0),
    );
  }

  //2張
  Widget _cover2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        const SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _cover3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        const SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _cover4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            const SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            const SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover6() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        const SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover7() {
    return Column(
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        const SizedBox(height: spaceSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover8() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            const SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        const SizedBox(height: spaceSize),
        Row(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
            const SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      widget.articleItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
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
