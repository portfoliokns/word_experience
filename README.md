# テーブル設計

## users テーブル ： ユーザー管理テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| name               | string  | null: false               |
| name_kana          | string  | null: false               |
| birth_date         | date    | null: false               |

### アソシエーション
has_many :words
has_many :exchanged_words
has_many :evolutions
belongs_to :word_point

##  wordsテーブル ： ワードテーブル

| Column              | Type       | Options                        |
| --------------      | ---------- | ------------------------------ |
| word                | string     | null: false                    |
| main_category_id    | integer    | null: false                    |
| service_category_id | integer    | null: false                    | 
| user                | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user
has_many :exchanged_words
has_many :evolutions

## exchanged_words ： 交換済みのワードテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| word          | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user
belongs_to :exchanged_word
has_many :evolutions

## evolutionsテーブル ： 評価テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| word           | references | null: false, foreign_key: true |
| exchanged_word | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user
belongs_to :word
belongs_to :exchanged_word


## word_pointテーブル ： ワードポイントテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| point    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### アソシエーション
belongs_to :user

