require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入ができる' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_delivery).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_delivery.building_name = ''
        expect(@purchase_delivery).to be_valid
      end
    end

    context '商品購入ができない' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_delivery.post_code = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが半角のハイフンがないと保存できないこと' do
        @purchase_delivery.post_code = '1111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it 'post_codeが全角を含むと保存できないこと' do
        @purchase_delivery.post_code = '１１１-１１１１'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end

      it 'Prefectureが「---」だと保存できないこと' do
        @purchase_delivery.prefecture_id = '1'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空だと保存できないこと' do
        @purchase_delivery.street_address = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_delivery.phone_number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが全角数字だと保存できないこと' do
        @purchase_delivery.phone_number = '０００００００００００'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid. Input only number.')
      end

      it 'phone_numberが12桁以上だと保存できないこと' do
        @purchase_delivery.phone_number = '012345678901'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid. Input only number.')
      end

      it 'phone_numberが9桁以下だと保存できないこと' do
        @purchase_delivery.phone_number = '012345678'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid. Input only number.')
      end

      it 'phone_numberにハイフンがあると保存できないこと' do
        @purchase_delivery.phone_number = '000-0000-0000'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid. Input only number.')
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_delivery.item_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
