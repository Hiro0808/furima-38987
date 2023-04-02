# データベース設計

## users　テーブル

| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| nickname              | string    | null:false                             |
| email                 | string    | null:false unique: true                |
| encrypted_password    | string    | null:false                             |
| last_name             | string    | null:false                             |
| first_name            | string    | null:false                             |
| last_name_kana        | string    | null:false                             |
| first_name_kana       | string    | null:false                             |
| birthday              | date      | null:false                             |

-has_many : items
-has_many : purchases


## itemsテーブル

| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| item_name             | string    | null:false                             |
| description           | text      | null:false                             |
| price                 | integer   | null:false                             |
| category_id           | integer   | null:false                             |
| condition_id          | integer   | null:false                             |
| shipping_burden_id    | integer   | null:false                             |
| prefecture_id         | integer   | null:false                             |
| date_of_shipment_id   | integer   | null:false                             |
| user                  |references | null:false,foreign_key:true            |


-belongs_to : user
-has_one : purchase



## purchases(購入記録)テーブル
| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| user                  |references | null:false,foreign_key:true            |
| item                  |references | null:false,foreign_key:true            |

-belongs_to : user
-belongs_to : item
-has_one : delivery





## deliverys(配送先)テーブル
| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| post_code             | string    | null:false                             |
| prefecture_id         | integer   | null:false                             |
| city                  | string    | null:false                             |
| street_address        | string    | null:false                             |
| building_name         | string    |                                        |
| phone_number          | string    | null:false                             |
| purchase              |references | null:false,foreign_key:true            |

-belongs_to : purchase
