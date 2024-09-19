import 'dart:math';

import 'package:flutter/cupertino.dart';

// 轉為 rpx
double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}

formatCharCount(int count) {
  if (count <= 0 || count.isNaN) {
    return '0';
  }

  String strCount = count.toString();
  if (strCount.length >= 5) {
    //38128 => 3.8w
    //38125 => 38.1w
    String prefix = strCount.substring(0, strCount.length - 4);
    if (strCount.length == 5) {
      prefix += '.${strCount[1]}';
    }
    if (strCount.length == 6) {
      prefix += '.${strCount[2]}';
    }
    return '${prefix}w';
  }
  return strCount;
}

//隨機獲取指定返回內的數值
int getRandomRangeInt(int min, int max) {
  final Random random = Random();
  return min + random.nextInt(max + 1 - min);
}

// 秒數轉 時:分:秒
String secondsToTime(int seconds) {
  if (seconds == null || seconds <= 0 || seconds.isNaN) {
    return '00:00';
  }
  // 時分數
  int hours = 0;
  // 分鐘數
  int minutes = 0;
  // 除整數分鐘外剩餘的秒數
  int remainingSeconds = 0;

  hours = (seconds / 60 / 60).floor();
  minutes = (seconds / 60 % 60).floor();
  remainingSeconds = seconds % 60;

  // 返回 時:分:秒
  return '${formatNumber(hours)}:${formatNumber(minutes)}:${formatNumber(remainingSeconds)}';
}

// 個數補零
String formatNumber(int count) {
  String strCount = count.toString();
  return strCount.length > 1 ? strCount : '0$strCount';
}
