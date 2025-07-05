# Flutter-MOD_TikTok_APP 

## 專案簡介
本專案是一個多平台（Android/iOS/Web/Windows/macOS/Linux）Flutter 仿 TikTok 應用，整合 Firebase，具備短影音、音樂、文章、用戶資訊等功能，並以元件化、資料模型、主題樣式等方式設計，方便擴充與維護。

## 項目預覽
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002332.png)
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002359.png)
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002425.png)
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002439.png)
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002451.png)
![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-24%20002504.png)

## 專案結構與檔案說明

### 根目錄
- `duuchin.sql`：資料庫初始化或備份腳本
- `preview_images/`：專案預覽截圖
- `README.md`：專案說明文件

### flutter_mod_tiktok_app/
#### 配置與資源
- `pubspec.yaml`：依賴與資源設定
- `analysis_options.yaml`：Dart 靜態分析規則
- `assets/`：靜態資源（圖片、icons）

#### 平台專屬
- `android/`、`ios/`、`web/`、`windows/`、`macos/`、`linux/`：各平台原生設定與啟動檔案

#### 程式主體
- `lib/main.dart`：應用程式進入點，初始化主題、路由、Firebase 等
- `lib/root_page.dart`：主頁面邏輯，底部導航與主內容切換
- `lib/transit_page.dart`：啟動頁，含 3 秒廣告與跳過功能

#### 元件
- `lib/components/`：可重用 UI 元件
  - `article_card.dart`：文章卡片
  - `avatar_role_name.dart`：頭像與角色名稱
  - `comment_like_read.dart`：評論、按讚、閱讀數
  - `root_page_head.dart`：主頁頭部
  - `singer_card.dart`：歌手卡片
  - `song_card.dart`：歌曲卡片
  - `tiny_video_card.dart`：小型短影音卡片
  - `video_card.dart`：短影音卡片

#### 設定
- `lib/config/`
  - `app_colors.dart`：全域色彩設定
  - `app_theme.dart`：主題樣式設定

#### Firebase 整合
- `lib/FireBaseTest/`
  - `add_data.dart`：新增資料到 Firebase
  - `connection_firebase.dart`：Firebase 連線設定
  - `fetch_data.dart`：從 Firebase 取得資料
  - `main.dart`：Firebase 測試主程式

#### 資料模型
- `lib/models/`
  - `article_model.dart`：文章資料結構
  - `song_model.dart`：歌曲資料結構
  - `user_model.dart`：用戶資料結構
  - `video_model.dart`：短影音資料結構

#### 工具
- `lib/utils/`
  - `user_type.dart`：用戶類型定義
  - `util.dart`：通用工具函式

#### 頁面
- `lib/view/root_pages/`：主頁相關頁面
- `lib/view/sub_pages/`：子頁面（如詳細頁、設定頁等）

---

## 主要功能
- [x] 啟動頁（3 秒廣告，可跳過）
- [x] 底部導航（IndexedStack 實現狀態緩存）
- [x] TabBar 切換（AutomaticKeepAliveClientMixin 實現狀態緩存）
- [x] 歌曲、歌手、短文、文章、影片等頁面（資料來自 Firebase）
- [x] 全域主題色、樣式統一管理

---

## 安裝與執行
1. 安裝 Flutter SDK 與 Dart 環境
2. 下載本專案並進入 `flutter_mod_tiktok_app` 目錄
3. 執行 `flutter pub get` 安裝依賴
4. 配置 Firebase（請將 `google-services.json`/`GoogleService-Info.plist` 放入對應資料夾）
5. 執行 `flutter run` 啟動專案

---

## 開發與貢獻
- 歡迎 issue、PR 與建議
- 請遵循元件化、資料模型、主題樣式等設計原則

---

## 參考資料
* [Flutter 官方文件](https://docs.flutter.dev/)
* [Flutter 與 Firebase 整合教學](https://www.youtube.com/watch?v=VCjG_v6oYyA)
* [IndexedStack 狀態緩存](https://api.flutter.dev/flutter/widgets/IndexedStack-class.html)
* [AutomaticKeepAliveClientMixin 狀態保持](https://api.flutter.dev/flutter/widgets/AutomaticKeepAliveClientMixin-mixin.html)

---

## 頁面緩存與狀態保持說明

### IndexedStack 實現底部導航狀態緩存
- 切換頁面時不會銷毀狀態，避免重複請求與重繪
- 適用於底部導航（如 TikTok 主頁、發現、訊息、個人頁）

### TabBar 狀態保持
- TabBarView 包裹頁面需繼承 StatefulWidget
- 混入 AutomaticKeepAliveClientMixin 並覆寫 wantKeepAlive
- 切換 Tab 時狀態不會遺失

---

## 目錄結構圖（簡化）

```
flutter_mod_tiktok_app/
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── assets/
│   └── images/
├── lib/
│   ├── main.dart
│   ├── root_page.dart
│   ├── transit_page.dart
│   ├── components/
│   ├── config/
│   ├── FireBaseTest/
│   ├── models/
│   ├── utils/
│   └── view/
└── ...
```

---