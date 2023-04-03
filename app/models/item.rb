class Item < ApplicationRecord
  has_one_attached :image

  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_burden
  belongs_to :prefecture
  belongs_to :date_of_shipment

  validates :item_name, :description, :price, presence: true
  validates :category_id, :condition_id, :shipping_burden_id, :prefecture_id, :date_of_shipment_id,numericality: { other_than: 1 ,message: "can't be blank"} 
end
