require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    I18n.locale = :ja
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のカナを入力してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字のカナを入力してください")
      end

      it 'first_nameに半角が含まれていると登録できない' do
        @user.first_name = 'ｼﾞｮﾌﾞｽﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角文字を使用してください")
      end

      it 'last_nameに半角が含まれていると登録できない' do
        @user.last_name = 'ｽﾃｨｰﾌﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角文字を使用してください")
      end

      it 'first_name_kanaにカタカナ以外の文字が含まれていると登録できない' do
        @user.first_name_kana = 'あ亜１！'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のカナ全角カナを使用してください")
      end

      it 'last_name_kanaにカタカナ以外の文字が含まれていると登録できない' do
        @user.last_name_kana = 'あ亜１！'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字のカナ全角カナを使用してください")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角で設定してください')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角で設定してください')
      end

      it 'passwordに全角が含まれていると登録できない' do
        @user.password = 'aaaaaａ'
        @user.password_confirmation = 'aaaaaａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角で設定してください')
      end


      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user).not_to be_valid # 保存前にバリデーションチェック
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
    end
  end
end
