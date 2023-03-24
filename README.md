#　データベース設計

##　users　テーブル

| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| nickname              | string    | null:false                             |
| email                 | string    | null:false :unique                     |
| password              | string    | null:false                             |
| password_confirmation | string    | null:false                             |
| last_name             | string    | null:false                             |
| first_name            | string    | null:false                             |
| last_name_kana        | string    | null:false                             |
| first_name_kana       | string    | null:false                             |
| birthday              | date      | null:false                             |

-has_many : items
-has_many : purchases
-has_one : deliverys


## itemsテーブル

| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| item_mame             | string    | null:false                             |
| image                 | text      | null:false                             |
| price                 | integer   | null:false                             |
| category              | string    | null:false                             |
| condition             | string    | null:false                             |
| shipping_burden       | string    | null:false                             |
| prefecture            | string    | null:false                             |
| date_of_shipment      | string    | null:false                             |
| user                  |references | null:false,foreign_key:true            |
|                       |           |                                        |
|                       |           |                                        |
|                       |           |                                        |
|                       |           |                                        |

-belongs_to : user
-has_one : purchases



## purchases(購入記録)テーブル
| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| user                  |references | null:false,foreign_key:true            |
| item                  |references | null:false,foreign_key:true            |
| delivery              |references | null:false,foreign_key:true            |

-belongs_to : user
-belongs_to : item
-has_one : deliverys





## deliverys(配送先)テーブル
| column                | type      | option                                 |
|-----------------------|-----------|----------------------------------------|
| post_code             | integer   | null:false                             |
| prefectur             | string    | null:false                             |
| city                  | string    | null:false                             |
| street_address        | string    | null:false                             |
| building_name         | string    |                                        |
| phone_number          | string    | null:false                             |
| purchase              |references | null:false,foreign_key:true            |
| user                  |references | null:false,foreign_key:true            |

-belongs_to : user
-belongs_to : purchase