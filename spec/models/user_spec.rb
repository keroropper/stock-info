require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録がうまくいく時' do
      it 'nickname,password,password_confirmationがあれば登録できる' do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録ができないとき' do 
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください", "ニックネームは2文字以上で入力してください")
      end
      it 'nicknameが1文字だと登録できない' do
        @user.nickname = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは2文字以上で入力してください")
      end
      it 'nicknameが7文字以上だと登録できない' do
        @user.nickname = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは6文字以内で入力してください")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailに＠が含まれていないと登録できない' do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください")
      end
    end
  end
end
