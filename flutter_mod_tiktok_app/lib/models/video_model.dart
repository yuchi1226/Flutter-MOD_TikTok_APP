import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/models/user_model.dart';

class VideoList {
  List<VideoItem> list;

  VideoList(this.list);
  factory VideoList.fromJson(List<dynamic> list) {
    return VideoList(
      list.map((item) => VideoItem.fromJson(item)).toList(),
    );
  }
}

class VideoItem {
  final int id;
  final int userid;
  final UserItem user;
  final String coverPictureUrl;
  final String videoUrl;
  final String title;
  final String intro;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int shareCount;
  final int contentSeconds;

  VideoItem({
    required this.id,
    required this.userid,
    required this.user,
    required this.coverPictureUrl,
    required this.videoUrl,
    required this.title,
    required this.intro,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.shareCount,
    required this.contentSeconds,
  });

  factory VideoItem.fromJson(dynamic item) {
    return VideoItem(
      id: item['id'],
      userid: item['userid'],
      user: UserItem.fromJson(item['user']),
      coverPictureUrl: item['coverPictureUrl'],
      videoUrl: item['videoUrl'],
      title: item['title'],
      intro: item['intro'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],
      shareCount: item['shareCount'],
      contentSeconds: item['contentSeconds'],
    );
  }
}
