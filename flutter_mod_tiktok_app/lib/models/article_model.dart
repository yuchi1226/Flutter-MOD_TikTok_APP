import 'package:flutter_mod_tiktok_app/models/user_model.dart';

class ArticleList {
  List<ArticleItem> list;

  ArticleList(this.list);

  factory ArticleList.fromJson(List<dynamic> list) {
    return ArticleList(
      list.map((item) => ArticleItem.fromJson(item)).toList(),
    );
  }
}

class ArticleItem {
  final int id;
  final int userId;
  final UserItem user;
  final String coverUrlList;
  final String title;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  ArticleItem({
    required this.id,
    required this.userId,
    required this.user,
    required this.coverUrlList,
    required this.title,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
  });

  factory ArticleItem.fromJson(dynamic item) {
    return ArticleItem(
      id: item['id'],
      userId: item['userId'],
      user: UserItem.fromJson(item['user']),
      coverUrlList: item['coverUrlList'],
      title: item['title'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],

    );
  }
}
