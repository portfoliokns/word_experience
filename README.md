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
has_many :words
has_many :exchanged_words
has_many :good_reputations
has_to :word_point

##  wordsテーブル ： ワードテーブル

| Column              | Type       | Options                        |
| --------------      | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| main_category_id    | integer    | null: false                    |
| service_category_id | integer    | null: false                    | 
| user                | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user
has_many :exchanged_words
<!-- has_many :good_reputations -->

## exchanged_words ： 交換済みのワードテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| word          | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user
belongs_to :word
has_many :good_reputations

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
belongs_to :user
belongs_to :word
<!-- belongs_to :exchanged_word -->
