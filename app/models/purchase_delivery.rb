class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number#, :token

  with_options presence: true do
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: "is invalid. Input only number." }
    validates :user_id, :item_id,:city, :street_address#, :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}


  def save
    purchase = Purchase.create(item_id: item_id,user_id: user_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end