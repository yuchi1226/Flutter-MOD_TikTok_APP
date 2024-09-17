import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final ArticleItem articleItem;
  const ArticleCard({super.key,required this.articleItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ArticleCard'),
    );
  }
}
