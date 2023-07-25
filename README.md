# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# [mimic-quiz]

## サービス概要
お互いのことを知れるゲームサービス。
仲間内だけでなく、初対面同士でも楽しめる内容です。

##　想定されるユーザー層
オンラインで遊ぶ・集まることが多い人

## サービスコンセプト
手軽に盛り上がれるオンラインゲームを考案しました。
休日は友人とオンラインでゲームをしていることが多いのですが、
面白いゲームに限って対戦そのものやルールの把握に時間がかかるものが多いです。
オンライン飲み会の合間などに手軽にできて
初対面でも盛り上がれるゲームがあればいいなと思ってこのサービスを考えました。
ゲーム勝敗そのものよりもプロセスが楽しめるものになっていると思います。

## 実装を予定している機能
### MVP
* ログイン
* 掲示板作成
* 掲示板参加
* ゲーム機能（掲示板内での機能）
  * 参加者に役割を与える機能（GMと一般プレーヤー）
  * 出題と回答（チャット機能）
  * 匿名投票機能
  * 参加者に得点を振り分け

### その後の機能
* 出題内容の登録
* 出題内容の候補表示（オートコンプリート）
* 回答までのカウントダウン機能
* Twitterでの結果拡散機能

## 画面遷移図-figmaリンク
https://www.figma.com/file/KUW27R7RI8tRJljhyvDZx6/Mimic-Quiz-UI?type=design&node-id=0-1&mode=design&t=1Ypd3MbjXzE1RjZU-0

## ER図
![](2023-07-18-17-29-15.png)
https://www.figma.com/file/KUW27R7RI8tRJljhyvDZx6/Mimic-Quiz-UI?type=design&node-id=0-1&mode=design&t=1Ypd3MbjXzE1RjZU-0
