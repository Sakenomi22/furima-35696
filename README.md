## usersテーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | string | null: false |


### Association
has_many :products
has_many :purchases

## productsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| status      | text       | null: false                    |
| judgement   | text       | null: false                    |
| area        | string     | null: false                    |
| days        | string     | null: false                    |
| price       | string     | null: false                    |
| category    | string     | null: false                    |
| user_id     | references | null: false ,foreign_key: true |

### Association
belongs_to :user
has_one :purchase

## purchasesテーブル

| Column      | Type       | Options                        |
|------------ | ---------- | ------------------------------ |
| user_id     | references | null: false ,foreign_key: true |
| products_id | references | null: false ,foreign_key: true |
| delivery_id | references | null: false ,foreign_key: true |

### Association
belongs_to :user
belongs_to :products
has_one :delivery

## deliveryテーブル

| Column      | Type    | Options     |
| ----------- | ------- | ----------- |
| postal_code | string  | null: false |
| prefectures | string  | null: false |
| city        | string  | null: false |
| block       | string  | null: false |
| building    | string  |             |
| number      | integer | null: false |

### Association
belongs_to :purchase