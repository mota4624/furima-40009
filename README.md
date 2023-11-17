# テーブル設計

## users テーブル

|       Column       |  Type  |         Options          |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| lastname           | string | null: false              |
| firstname          | string | null: false              |
| lastname_kana      | string | null: false              |
| firstname_kana     | string | null: false              |
| birthdate          | date   | null: false              |


### Association

- has_many :items
- has_many :orders



## items テーブル

|     Column     |    Type    |            Options             |
| -------------- | ---------- | ------------------------------ |
| itemname       | string     | null: false                    |
| description    | text       | null: false                    |
| category       | genre_id   | null: false                    |
| condition      | genre_id   | null: false                    |
| shippingfee    | genre_id   | null: false                    |
| shippingorigin | genre_id   | null: false                    |
| deliverytime   | genre_id   | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- belongs_to :genre


## orders テーブル

| Column |    Type    |            Options             |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery



## addresses テーブル

|   Column    |    Type    |            Options             |
| ----------- | ---------- | ------------------------------ |
| postalcode  | string     | null: false                    |
| prefecture  | string     | null: false                    |
| city        | string     | null: false                    |
| housenumber | string     | null: false                    |
| building    | string     |                                |
| phone       | string     | null: false                    |
| order       | references | null: false, foreign_key: true |

### Association

- belongs_to :order

