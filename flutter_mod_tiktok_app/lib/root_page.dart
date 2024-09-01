import 'package:flutter/material.dart';

import 'config/app_colors.dart';
import 'view/root_pages/home_page.dart';
import 'view/root_pages/music_page.dart';
import 'view/root_pages/profile.dart';
import 'view/root_pages/tiny_video.dart';


class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

const Map<String, String> _bottomNames = {
  'home': '首頁',
  'music': '音樂',
  'create_media': '',
  'tiny_video': '短片',
  'profile': '我的',
};

class _RootPageState extends State<RootPage> {
  //當前選中頁索引
  int _currentIndex = 0;
  //頁面集合
  final List<Widget> _pages = [
    const HomePage(),
    const MusicPage(),
    Container(),
    const TinyVideoPage(),
    const ProfilePage(),
  ];
  //底部導航數組
  final List<BottomNavigationBarItem> _bottomNavBatList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //生成底部導航
    _bottomNames.forEach((key, value) {
      _bottomNavBatList.add(_bottomNavBatItem(key, value));
    });
  }

  //底部切換
  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreatMedia();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  //點擊發布按鈕
  void _onCreatMedia() {
    print('_onCreatMedia');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBatList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _creatMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //發布按鈕
  Widget _creatMediaButton() {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.only(top: 55),
      child: FloatingActionButton(
        backgroundColor: AppColors.nav,
        onPressed: _onCreatMedia,
        child: Image.asset(
          'assets/images/icons/create_media.png',
        ),
      ),
    );
  }

  //底部導航的每一項組件
  BottomNavigationBarItem _bottomNavBatItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/images/icons/$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        'assets/images/icons/${key}_active.png',
        width: 24,
        height: 24,
      ),
      label: value,
      tooltip: '',//去掉常按的提示字
    );
  }
}
