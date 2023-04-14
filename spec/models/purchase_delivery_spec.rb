require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    I18n.locale = :ja
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
        expect(@purchase_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'post_codeが半角のハイフンがないと保存できないこと' do
        @purchase_delivery.post_code = '1111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'post_codeが全角を含むと保存できないこと' do
        @purchase_delivery.post_code = '１１１-１１１１'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'Prefectureが「---」だと保存できないこと' do
        @purchase_delivery.prefecture_id = '1'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'cityが空だと保存できないこと' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'street_addressが空だと保存できないこと' do
        @purchase_delivery.street_address = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_delivery.phone_number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberが全角数字だと保存できないこと' do
        @purchase_delivery.phone_number = '０００００００００００'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phone_numberが12桁以上だと保存できないこと' do
        @purchase_delivery.phone_number = '012345678901'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phone_numberが9桁以下だと保存できないこと' do
        @purchase_delivery.phone_number = '012345678'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phone_numberにハイフンがあると保存できないこと' do
        @purchase_delivery.phone_number = '000-0000-0000'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_delivery.item_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Itemを入力してください")
      end

      it "tokenが空では登録できないこと" do
        @purchase_delivery.token = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("クレジットカード情報入力を入力してください")
      end
    end
  end
end
