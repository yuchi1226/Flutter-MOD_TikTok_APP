import 'package:flutter/cupertino.dart';
import 'user_model.dart';


/// 列表模型
class SongList {
  /// 包含 UserItem 模型的集合
  final List<SongItem> list;
  
  SongList(this.list);

  /// 循環後台返回的數組，將每一項組裝成 UserItem
  factory SongList.fromJson(List<dynamic> list) {
    return SongList(
      list.map((item) => SongItem.fromJson(item)).toList(),
    );
  }
}

/// 列表項/詳情模型
class SongItem {
  /// 此處定義數據表中的字段(或接口返回的)即可
  final int id;
  final int userId;
  //final UserItem userEntity; // 這個是用户模型
  final String coverPictureUrl;
  final String songUrl;
  final String cnName;
  final String enName;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem user;

  SongItem({
    required this.id,
    required this.userId,
    //@required this.userEntity,
    required this.coverPictureUrl,
    required this.songUrl,
    required this.cnName,
    required this.enName,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.user,
  });
  /// 將 Json 數據轉換為實體模型
  factory SongItem.fromJson(dynamic item) {
    return SongItem(
      id: item['id'],
      userId: item['userId'],
      //userEntity: UserItem.fromJson(item['user']), // 將用户數據轉為用户模型
      coverPictureUrl: item['coverPictureUrl'],
      songUrl: item['songUrl'],
      cnName: item['cnName'],
      enName: item['enName'],
      commentCount: item['commentCount'],
      thumbUpCount: item['thumbUpCount'],
      readCount: item['readCount'],
      user: UserItem.fromJson(item['user']),
    );
  }
}
