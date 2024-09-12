import 'package:flutter/material.dart';
import 'package:flutter_mod_tiktok_app/config/app_colors.dart';
import 'package:flutter/cupertino.dart';
class UserType {
  static Map enType = {
    'NORMAL_USER': 'NORMAL_USER',
    'DQ_SINGER': 'DQ_SINGER',
    'DQ_OFFICIAL_ACCOUNT': 'DQ_OFFICIAL_ACCOUNT',
    'ADMIN': 'ADMIN',
  };

  static Map cnType = {
    'NORMAL_USER': '普通用戶',
    'DQ_SINGER': '讀琴歌手',
    'DQ_OFFICIAL_ACCOUNT': '讀琴號',
    'ADMIN': '管理員',
  };

  static Map colorType = {
    'NORMAL_USER': AppColors.unactive,
    'DQ_SINGER': AppColors.info,
    'DQ_OFFICIAL_ACCOUNT': AppColors.success,
    'ADMIN': AppColors.danger,
  };
  //轉英文
  static formEn(String type) {
    return enType[type];
  }

  //轉中文
  static formCn(String type) {
    return cnType[type] ?? '遊客用戶';
  }

  //轉顏色
  static Color formColor(String type) {
    return colorType[type] ?? AppColors.unactive;
  }
  //是否是普通用戶
  static bool isNormal(String type) => type == enType['NORMAL_USER'];
  static bool isSINGER(String type) => type == enType['DQ_SINGER'];
  static bool isOFFICIAL(String type) => type == enType['DQ_OFFICIAL_ACCOUNT'];
  static bool isADMIN(String type) => type == enType['ADMIN'];
}
