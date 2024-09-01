//啟動頁
import 'dart:async';
import 'package:flutter/material.dart';

import 'root_page.dart';


class TransitPage extends StatefulWidget {
  const TransitPage({super.key});

  @override
  State<TransitPage> createState() => _TransitPageState();
}

class _TransitPageState extends State<TransitPage> {
  late Timer _timer;
  int _currentTime = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        _jumpRootPage();
      }
    });
  }

  //跳轉首頁
  void _jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return const RootPage();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/common/page.png',
            fit: BoxFit.cover, //圖片占滿整張屏幕(自動調整大小)
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            right: 10,
            child: InkWell(
              onTap: _jumpRootPage,
              child: _cilpButton(),
            ),
          ),
        ],
      ),
    );
  }

  //跳過按鈕
  Widget _cilpButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 65,
        height: 30,
        color: Colors.black.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_currentTime}s | ',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const Text(
              '跳過',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
