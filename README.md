## usersテーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| encrypted_password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |


### Association
has_many :products
has_many :purchases

## productsテーブル

| Column          | Type       | Options                      |
| --------------- | ---------- | ---------------------------- |
| name            | string     | null: false                  |
| description     | text       | null: false                  |
| category_id     | integer    | null: false                  |
| status_id       | integer    | null: false                  |
| judgement_id    | integer    | null: false                  |
| area_id         | integer    | null: false                  |
| delivery_day_id | integer    | null: false                  |
| price           | integer    | null: false                  |
| user            | references | null: false ,foreign_key:true|

### Association
belongs_to :user
has_one :purchase

## purchasesテーブル

| Column   | Type       | Options                        |
|--------- | ---------- | ------------------------------ |
| user     | references | null: false ,foreign_key: true |
| product  | references | null: false ,foreign_key: true |

### Association
belongs_to :user
belongs_to :product
has_one :delivery

## deliveriesテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | -------------------------------|
| postal_code | string     | null: false                    |
| area_id     | integer    | null: false                    |
| city        | string     | null: false                    |
| block       | string     | null: false                    |
| building    | string     |                                |
| number      | string     | null: false                    |
| purchase    | references | null: false, foreign_key: true |

### Association
belongs_to :purchase