# Flutter-MOD_TikTok_APP 

## 項目預覽


## 頁面結構 
### Lib/  
&emsp;components/ =>全域元件   
&emsp;config/ =>配置  
&emsp;models/ =>模型   
&emsp;utils/ =>工具  
&emsp;pages/ => 頁面  
&emsp;app_page.dart // 根頁面  
&emsp;main.dart => 入口文件  
&emsp;tansit_page.dart =>啟動頁 

## 頁面緩存  

#### **底部bottomNavigationBar頁面資料緩存**
常用的 app 都有底部的切換功能，就像這樣：

![](https://github.com/yuchi1226/Flutter-MOD_TikTok_APP/blob/main/preview_images/%E8%9E%A2%E5%B9%95%E6%93%B7%E5%8F%96%E7%95%AB%E9%9D%A2%202024-09-22%20235850.png?raw=true)

每次切換頁面，都會重新繪製頁面，結果很顯然，頁面的狀態將會遺失。  
  
這就搬出來一個元件 IndexedStack，它就像是 stack 元件一樣層疊在一起，事實上內部就是 statck 來實現的，它可以頁面切換時不會去銷毀或替換當前頁，而是層疊在一起。


 
---
<!-- 
## 參考資料 -- BV1LK4y1P7BB

* 使用 VS Code 開發 Flutter App — 建立專案，打開專案和啟動模擬器執行 App:https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-flutter-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E4%BD%BF%E7%94%A8-vs-code-%E9%96%8B%E7%99%BC-flutter-app-%E5%BB%BA%E7%AB%8B%E5%B0%88%E6%A1%88-%E6%89%93%E9%96%8B%E5%B0%88%E6%A1%88%E5%92%8C%E5%95%9F%E5%8B%95%E6%A8%A1%E6%93%AC%E5%99%A8%E5%9F%B7%E8%A1%8C-app-213054edc169

* How to Connect Flutter App with Firebase:https://www.youtube.com/watch?v=VCjG_v6oYyA

* Failed to load FirebaseOptions from resource. Check that you have defined values.xml correctly:https://www.youtube.com/watch?v=bHxoJWWsG7A

* 類別的建構子中，參數不能為null:https://blog.csdn.net/shulianghan/article/details/119918924

-- >