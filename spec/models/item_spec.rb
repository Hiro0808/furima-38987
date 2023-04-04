require 'rails_helper'

RSpec.describe @item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる場合' do
      it 'item_name、 description、price、image、category、condition、shipping_burden、prefecture、date_of_shipmentが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end


      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'shipping_burden_idが空では登録できない' do
        @item.shipping_burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping burden can't be blank")
      end

      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'date_of_shipment_idが空では登録できない' do
        @item.date_of_shipment_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Date of shipment can't be blank")
      end

      it 'priceに全角数字や数字意外が含まれていると登録できない' do
        @item.price= '１００あ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceの値が300未満だと登録できない' do
        @item.price= '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceの値が10,000,000以上だと登録できない' do
        @item.price= '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end

