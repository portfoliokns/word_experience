
# アプリケーション名
アプリケーション名は、「Word Experience」と言います。

<br>

# アプリケーション概要
このアプリケーションは、他のユーザーが各種サービスで使用している検索ワードや使用している言葉など、価値ある”ワード”を提供し合うアプリになります。提供しあった”ワード”をもとに、各種サービスで利用してもらい、新たな価値や体験をしてもらうことを目的にしています。

<br>

# URL
以下のURLからアクセスしてください。
- https://word-experience.link/

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
4. そのワードをもとに、Youtubeなどのサービスで検索し、新たな体験をしましょう。サービスをクリックすると、そのサイトにアクセスすることができます。
5. 新たな体験ができたら、高評価ボタン（☆）をクリックして、そのワードを評価しましょう。もしくは新たな体験ができなかった、あるいはそれが不適切なワードであった場合、低評価ボタン（×）をクリックして、フィードバックしましょう。

## その他の機能
- ユーザー情報編集・削除する機能
- パスワードを変更する機能
- ユーザーのプロフィールを確認する機能(投稿されたワードの高評価率などを確認できる)
- ワード編集・削除（ワードポイントを消費します）
- スマートフォンで利用できる機能(Webレスポンシブデザイン)

## 利用時の注意点
このアプリは、以下の環境で開発・テストしました。そのため他の環境で実行した場合、デザインが崩れるなど不具合が起こる可能性があります。（全てのOS、ブラウザで動作を保証するものではありません）
- OS：macOS Ventura 13.0.1
- ブラウザ：GoogleChrome バージョン: 108.0.5359.124（Official Build） （arm64）

またスマートフォンでは以下のものを使用しています。
- スマートフォン：iPhoneSE(2G)
- バージョン：iOS 16.1.1
- ブラウザ：GoogleChrome バージョン: 108.0.5359.112

## 備考
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
アプリケーション上の操作マニュアル動画を参照してください。なおアップデートに伴いデザインが変更されていたり、アップデートされた機能の動画が準備されていない場合もあります。あらかじめご了承ください。
- https://word-experience.link/manuals

<br>

# オリジナルアプリ作成完了から実装した機能
- 低評価ボタン（×）の追加
- 操作マニュアルページの追加、および操作説明のyoutube動画を追加
- ユーザープロフィール確認機能の追加（ワードの高評価率を確認することができます）
- デザインを一新（クライアント端末やブラウザの環境によって、bootstrapを適応した箇所のデザインが崩れることを確認したため、一新しました）
- reCAPTCHAの実装
- パスワード変更ができる機能を実装
- Aboutページを実装(ウェブアクセシビリティ対応)
- 各種サービスへ、直接アクセスできる機能
- スマートフォンで利用できる機能(Webレスポンシブデザイン)
- HTTP通信をHTTPS通信へ切り替え（フリードメインの取得、EC2の設定変更）

<br>

# 実装予定の機能
- ワードを一覧の数を制限する機能
- エラーメッセージの詳細を表示する機能（現状では自分のワードを登録する際の、エラーの詳細がわからないため、ユーザーが混乱してしまう）
- "ワード"ランキングページの追加
- ワード交換アルゴリズムの修正（現在、このアルゴリズムはデータの数が増えるほど、アプリケーションサーバーのパフォーマンスに影響を及ぼす潜在的な問題を抱えています。なおフォートフォリオとして動作させるだけであれば、問題ありません）
- ワードの検索機能
- ワード交換時の機能追加（交換できる数を可変にできる機能、条件の絞り込み機能など）

<br>

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/f293b6eed6983f8a9d5172a7d6c5fa90.png)](https://gyazo.com/f293b6eed6983f8a9d5172a7d6c5fa90)

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

## inquiriesテーブル ： 高評価テーブル

| Column              | Type       | Options                        |
| --------------      | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| email               | string     | null: false                    |
| detail              | string     | null: false                    |


### アソシエーション
なし

<br>

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/d61c17cc28cda67a14417ab27613f206.png)](https://gyazo.com/d61c17cc28cda67a14417ab27613f206)

<br>

# 開発環境	使用した言語・サービスを記載。
- フロントエンド：HTML、CSS、JavaScript
- バックエンド：Ruby、Ruby on Rails
- インフラ：AWS(EC2,Route53)、Nginx、Gmail
- タスク管理：GitHub、スプレッドシート
- その他：YouTube、Google reCAPTCHA

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
BASIC_AUTH_USER='admin'・・・文字列
BASIC_AUTH_PASSWORD='5678'・・・文字列
WORD_POINT_CREATE="200"・・・整数
WORD_POINT_UPDATE="15"・・・整数
WORD_POINT_DESTROY="25"・・・整数
WORD_POINT_EXCHANGE="50"・・・整数
GMAIL_MAILER_ADDRESS="smtp.gmail.com"
GMAIL_PORT_NUMBER="587"
GMAIL_ADMIN_ADDRESS="送信先となるGメールアドレス"
GMAIL_APP_PASSWORD="Gメールのアプリケーションパスワード"
```

<br>

# 工夫したポイント
- 交換機能：「他のユーザーが登録したワード」かつ「自身が既に交換したワード以外のワード」を取得するための機能がActiveRecordだけで、実現できませんでした。そのためアルゴリズムを別途構築し、実現しました。
- ワードの一括登録機能：ワードを一つ一つ登録するのはユーザービリティに影響を与えてしまうことを考えていました。そのため複数のワードを一括で登録するための機能を、トランザクション処理を用いて実装しました。
- Webレスポンシブデザイン機能：昨今は過去と比べて、PCによる利用よりもスマートフォンでの利用が増えている。そのためアプリの利用者を増やすためにも、Webレスポンシブデザイン対応は必須と考えていた。TechCampの通常カリキュラムにはWebレスポンシブデザインの内容がほぼないため、しまぶーのIT大学の動画を参考に実装を行なった。ITエンジニア(プログラマー)の友人にも協力いただき、スマートフォンでも利用ができるよう、実装を行なった。https://www.youtube.com/watch?v=xdUjlpHRX0U
- SSL化を導入：HerokuからAWSへ乗り換えた時、HTTPSになっていないことが気に入りませんでした。クライアントとサーバー間で暗号化されていない以上、セキュリティの不安やアプリケーションとしてできることの幅を狭めていたので、対応しました。対応した際の内容はQiitaに記録しています。
https://qiita.com/portfoliokns3/items/36aa98a2ecce7da1c708
https://qiita.com/portfoliokns3/items/bfbdf8cf49a7d205695a
