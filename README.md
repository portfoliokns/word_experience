
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
5. 新たな体験ができたら、高評価ボタン（☆）をクリックして、そのワードを評価しましょう。もしくは新たな体験ができなかった、あるいはそれが不適切なワードであった場合、低評価ボタン（×）をクリックして、フィードバックしましょう。

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

# 実装した機能についての説明
アプリケーション上の操作マニュアル動画を参照してください。
- http://35.73.136.1/manuals

<br>

# オリジナルアプリ作成完了から実装した機能
- 低評価ボタン（×）の追加
- 操作マニュアルページの追加、および操作説明のyoutube動画を追加

<br>

# 実装予定の機能
- プロフィール機能の追加（他のユーザーがプロフィールを閲覧できる機能やユーザー自身が編集できる機能）
- ワードを一覧の数を制限する機能
- エラーメッセージの詳細を表示する機能（現状では自分のワードを登録する際の、エラーの詳細がわからないため、ユーザーが混乱してしまう）
- パスワード変更ページの追加
- "ワード"ランキングページの追加
- HTTP通信をHTTPS通信へ切り替え（フリードメインの取得、EC2の設定変更）
- ワード交換アルゴリズムの修正（現在、このアルゴリズムはデータの数が増えるほど、アプリケーションサーバーのパフォーマンスに影響を及ぼす潜在的な問題を抱えています。なおフォートフォリオとして動作させるだけであれば、問題ありません）
- ワードの検索機能
- ワード交換時の機能追加（交換できる数を可変にできる機能、条件の絞り込み機能など）

<br>

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/d22cf7c37ac49d4cde4da1c3a4072ca4.png)](https://gyazo.com/d22cf7c37ac49d4cde4da1c3a4072ca4)

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
has_many :good_reputations

## exchanged_words ： 交換済みのワードテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| word          | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user<br>
belongs_to :word<br>
has_many :good_reputations

## word_pointテーブル ： ワードポイントテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| point    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user

## reputationsテーブル ： 高評価テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| word           | references | null: false, foreign_key: true |
| exchanged_word | references | null: false, foreign_key: true |
| star_flag      | boolean    | null: false |
| bad_flag       | boolean    | null: false |

### アソシエーション
belongs_to :user<br>
belongs_to :word<br>
belongs_to :exchanged_word

<br>

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/ef4cc425f30a0290e5e05391fd73b3b0.png)](https://gyazo.com/ef4cc425f30a0290e5e05391fd73b3b0)

<br>

# 開発環境	使用した言語・サービスを記載。
- フロントエンド：HTML、CSS、JavaScript
- バックエンド：Ruby、Ruby on Rails
- インフラ：AWS(EC3)
- タスク管理：GitHub
- その他：YouTube

<br>

# ローカルでの動作方法
```
% git clone https://github.com/konishi333/word_experience
% cd word_experience
% bundle install
% yarn install
```
なおこのアプリをローカルで動作させるには、以下の環境変数を別途、設定する必要があります。なお環境変数を設定する場合は、既存の変数を誤って変更・削除しないようご注意ください。
```
BASIC_AUTH_USER='----'・・・文字列
BASIC_AUTH_PASSWORD='----'・・・文字列
WORD_POINT_CREATE="----"・・・整数
WORD_POINT_UPDATE="----"・・・整数
WORD_POINT_DESTROY="----"・・・整数
WORD_POINT_EXCHANGE="----"・・・整数
```

<br>

# 工夫したポイント
- 交換機能：「他のユーザーが登録したワード」かつ「自身が既に交換したワード以外のワード」を取得するための機能がActiveRecordだけで、実現できませんでした。そのためアルゴリズムを別途構築し、実現しました。
- ワードの一括登録機能：ワードを一つ一つ登録するのはユーザービリティに影響を与えてしまうことを考えていました。そのため複数のワードを一括で登録するための機能を、トランザクション処理を用いて実装しました。
