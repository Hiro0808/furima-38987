class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token

  with_options presence: true do
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/}
    validates :user_id, :item_id,:city, :street_address, :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: {other_than: 1, message: "を入力してください"}
  end

  def save
    purchase = Purchase.create(item_id: item_id,user_id: user_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end