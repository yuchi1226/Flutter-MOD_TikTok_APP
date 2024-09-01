import 'package:flutter/cupertino.dart';

// 轉為 rpx
double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}
