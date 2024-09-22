# Flutter-MOD_TikTok_APP 

## 項目預覽


## 頁面結構 
- [x] **Lib/**  
&emsp;components/ =>全域元件   
&emsp;config/ =>配置  
&emsp;models/ =>模型   
&emsp;utils/ =>工具  
&emsp;pages/ => 頁面  
&emsp;app_page.dart // 根頁面  
&emsp;main.dart => 入口文件  
&emsp;tansit_page.dart =>啟動頁 

## 項目頁面
- [x] 歌曲、歌手、短文、文章、影片等頁面編寫完成。資料從 FireBase fetch 

## 常用Colors、主題樣式  
- [x] config下新建 app_colors.dart檔、app_thumb.dart檔，內包含主題色、頁面背景色、選項卡欄的顏色、文字顏色等等。為此項目的主要構成顏色，可從此檔中呼叫，不需反覆編寫。

## 頁面緩存  

- [x] **底部bottomNavigationBar頁面資料緩存**
常用的 app 都有底部的切換功能，就像這樣：

![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-22%20235850.png?raw=true)

每次切換頁面，都會重新繪製頁面，結果很顯然，頁面的狀態將會遺失。  
  
這就搬出來一個元件 IndexedStack，它就像是 stack 元件一樣層疊在一起，事實上內部就是 statck 來實現的，它可以頁面切換時不會去銷毀或替換當前頁，而是層疊在一起。

![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/image.png?raw=true)

這樣切換頁面，頁面的狀態不會被遺失，如果做了網路請求，那麼就不會去頻繁的刷新資料了。

- [x] **TabBar 切換頁面資料緩存**
Tabbar 切換已經是所有 app 中常見的場景了，flutter 也提供了這個元件，讓我們很快速簡單的實作這個功能

![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-22%20235917.png?raw=true)

但如同上面的 bottomNavigationBar，它每次切換，並不會去保持頁面的狀態，而是每次都會重新取繪製。 如果要實現頁面緩存，需遵循幾個注意點：  
1.被 tabbarView 包裹的頁面必須繼承自 StatefulWidget  
2、該頁面的state必須混入 AutomaticKeepAliveClientMixin  
3、該頁面中重寫 wantKeepAlive 具體寫法如下，紅框的部分你必須這麼做：  

![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/image%20(1).png?raw=true)

做了以上配置，你如果在 build 中 print 一下，當你切換 tabbar 時，print 就不會列印，也就實現了頁面保持狀態。
 
---
<!-- 
## 參考資料 -- BV1LK4y1P7BB

* 使用 VS Code 開發 Flutter App — 建立專案，打開專案和啟動模擬器執行 App:https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-flutter-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E4%BD%BF%E7%94%A8-vs-code-%E9%96%8B%E7%99%BC-flutter-app-%E5%BB%BA%E7%AB%8B%E5%B0%88%E6%A1%88-%E6%89%93%E9%96%8B%E5%B0%88%E6%A1%88%E5%92%8C%E5%95%9F%E5%8B%95%E6%A8%A1%E6%93%AC%E5%99%A8%E5%9F%B7%E8%A1%8C-app-213054edc169

* How to Connect Flutter App with Firebase:https://www.youtube.com/watch?v=VCjG_v6oYyA

* Failed to load FirebaseOptions from resource. Check that you have defined values.xml correctly:https://www.youtube.com/watch?v=bHxoJWWsG7A

* 類別的建構子中，參數不能為null:https://blog.csdn.net/shulianghan/article/details/119918924

-- >