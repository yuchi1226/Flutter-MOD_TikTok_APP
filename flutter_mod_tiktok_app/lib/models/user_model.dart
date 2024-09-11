
/// 用户列表項/用户詳情模型
class UserItem {
  /// 此處定義數據表中的字段(或接口返回的)即可
  final int id;
  final String coverPictureUrl;
  final String nickname;
  final String type;
  final int musicCount;
  final int musicPlayCount;

  UserItem({
    required this.id,
    required this.coverPictureUrl,
    required this.nickname,
    required this.type,
    required this.musicCount,
    required this.musicPlayCount,
  });
	/// 將 Json 數據轉換為實體模型
  factory UserItem.fromJson(dynamic item) {
    return UserItem(
      id: item['id'],
      coverPictureUrl: item['coverPictureUrl'],
      nickname: item['nickname'],
      type: item['type'],
      musicCount: item['musicCount'],
      musicPlayCount: item['musicPlayCount'],
    );
  }
}