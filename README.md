
# アプリケーション名
アプリケーション名は、「Word Experience」と言います。

<br>

# アプリケーション概要
このアプリケーションは、他のユーザーが各種サービスで使用している検索ワードや使用している言葉など、価値ある”ワード”を提供し合うアプリになります。提供しあった”ワード”をもとに、各種サービスで利用してもらい、新たな価値や体験をしてもらうことを目的にしています。

<br>

# URL
以下のURLからアクセスしてください。
- http://35.73.136.1/

<br>

# テスト用アカウント
## Basic認証
- ID：admin
- Password：5678

## テストアカウント
- Email Address：test@test
- Password：test5678<br>
  - こちらのテストアカウントは削除しないでください。さまざまな方が使用することを想定しています。<br>
  - 任意のアカウントを作成していただいても構いません。その際、個人情報は入力しないでください。またユーザー編集ページから、登録した情報をすべて削除させることができます。

<br>

# 利用方法
## 基本的な機能
1. 新規登録ページからユーザーアカウントを作成します。
2. 登録ページから自分のおすすめするワードを登録し、ワードポイントを取得します。
3. 交換ページからワードポイントを消費して、他ユーザーのワードを取得します。なおワードはランダムに選ばれます。
4. そのワードをもとに、Youtubeなどのサービスで検索し、新たな体験をしましょう。
5. 新たな体験ができたら、エクセレントボタン（☆）をクリックして、そのワードを評価しましょう。

## その他の機能
- ユーザー情報編集・削除する機能
- ワード編集・削除（ワードポイントを消費します）

## 備考
- 「ワードをクリックすると、クリップボードへコピーする」機能も実装しています。しかしHTTPSの通信でないため、エラーとなってしまいます。
- 交換するためのワードの数が十分にない場合、交換ができません。また自分が登録したワードは交換の対象外になります。

<br>

# アプリケーションを作成した背景
YoutubeやAmazonといった大手IT企業のサービスなどでは、パーソナライゼーションされた情報が目に入るようになっており、それ以外の情報に触れる機会があまりない。<br>
またソーシャルメディア上あるいはコミュニケーションツール上では、自分とよく似た趣味思考の人々の中でグループを形成してしまっている。つまりエコーチェンバー現象の中で、似通った情報にしか触れる機会がなく、新たな体験をしたいと思っても、そのきっかけを得ることは滅多にない。<br>
私は新たな価値や体験を得る機会が少なく、この問題を抱えていました。現在のインターネット社会を分析した結果、まずはそのきっかけを得ることが必要と考え、このアプリケーションを開発しました。

<br>

# 洗い出した要件
以下のスプレッドシートに記載しています。
- https://docs.google.com/spreadsheets/d/1yzDRJ6sSt-AF3oIAkdFZPp3kPQ1zRaSLwDUKOSCbEDo/edit#gid=982722306

# 実装した機能についての画像やGIFおよびその説明
- ワード登録機能
[![Image from Gyazo](https://i.gyazo.com/fb7b76d7565ca1fb3de99f6b78285451.gif)](https://gyazo.com/fb7b76d7565ca1fb3de99f6b78285451)

- ワード交換機能
[![Image from Gyazo](https://i.gyazo.com/68937e7200b881e4c920f01600e9bbe6.gif)](https://gyazo.com/68937e7200b881e4c920f01600e9bbe6)

- コピー機能（HTTPSでない場合は機能しません）
[![Image from Gyazo](https://i.gyazo.com/aa3e7ded686df7506cfcc71336250485.gif)](https://gyazo.com/aa3e7ded686df7506cfcc71336250485)

<br>

# 実装予定の機能
- 低評価ボタン（👎）の追加
- プロフィール機能の追加（他のユーザーがプロフィールを閲覧できる機能やユーザー自身が編集できる機能）
- ワードを一覧の数を制限する機能
- エラー時のメッセージ表示
- パスワード変更ページの追加
- "ワード"ランキングページの追加

<br>

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/1e13ee58b2abcb2e26310887dce1c0be.png)](https://gyazo.com/1e13ee58b2abcb2e26310887dce1c0be)

<br>

# テーブル設計

## users テーブル ： ユーザー管理テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birth_date         | date    | null: false               |

### アソシエーション
has_many :words<br>
has_many :exchanged_words<br>
has_many :good_reputations<br>
has_many :bad_reputations<br>
has_to :word_point

##  wordsテーブル ： ワードテーブル

| Column              | Type       | Options                        |
| --------------      | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| main_category_id    | integer    | null: false                    |
| service_category_id | integer    | null: false                    | 
| user                | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user<br>
has_many :exchanged_words<br>
has_many :good_reputations<br>
has_many :bad_reputations

## exchanged_words ： 交換済みのワードテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| word          | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user<br>
belongs_to :word<br>
has_many :good_reputations<br>
has_many :bad_reputations

## word_pointテーブル ： ワードポイントテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| point    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user

## good_reputationsテーブル ： 高評価テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| word           | references | null: false, foreign_key: true |
| exchanged_word | references | null: false, foreign_key: true |
| star_flag      | boolean    | null: false |

### アソシエーション
belongs_to :user<br>
belongs_to :word<br>
belongs_to :exchanged_word

## bad_reputationsテーブル ： 低評価テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| word           | references | null: false, foreign_key: true |
| exchanged_word | references | null: false, foreign_key: true |
| bad_flag      | boolean    | null: false |

### アソシエーション
belongs_to :user<br>
belongs_to :word<br>
belongs_to :exchanged_word

<br>

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/b4443cf82d2076b2c594797ccc94a2f5.png)](https://gyazo.com/b4443cf82d2076b2c594797ccc94a2f5)

<br>

# 開発環境	使用した言語・サービスを記載。
- フロントエンド：HTML、CSS、JavaScript
- バックエンド：Ruby、Ruby on Rails
- インフラ：AWS(EC3)
- タスク管理：GitHub

<br>

# ローカルでの動作方法
```
% git clone https://github.com/konishi333/word_experience
% cd word_experience
% bundle install
% yarn install
```
<br>

# 工夫したポイント
- 交換機能：「他のユーザーが登録したワード」かつ「自身が既に交換したワード以外のワード」を取得するための機能がActiveRecordだけで、実現できませんでした。そのためアルゴリズムを別途構築し、実現しました。
- ワードの一括登録機能：ワードを一つ一つ登録するのはユーザービリティに影響を与えてしまうことを考えていました。そのため複数のワードを一括で登録するための機能を、トランザクション処理を用いて実装しました。
