require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nicknameとemail、passwordとpassword_confirmation、lastnameとfirstname、lastname_kanaとfirstname_kana、birthdateが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "lastnameが空では登録できない" do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname can't be blank")
      end
      it "firstnameが空では登録できない" do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end
      it "lastname_kanaが空では登録できない" do
        @user.lastname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
      end
      it "firstname_kanaが空では登録できない" do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end
      it "birthdateが空では登録できない" do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')

      end
      it 'passwordが半角数字だけでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and number')
      end
      it 'passwordが半角英字だけでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and number')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'lastnameが半角では登録できない' do
        @user.lastname = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname Input full-width characters")
      end
      it 'firstnameが半角では登録できない' do
        @user.firstname = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname Input full-width characters")
      end
      it 'lastname_kanaが半角では登録できない' do
        @user.lastname_kana = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana Input full-width katakana characters")
      end
      it 'firstname_kanaが半角では登録できない' do
        @user.firstname_kana = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana Input full-width katakana characters")
      end
      it 'lastname_kanaが全角漢字では登録できない' do
        @user.lastname_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana Input full-width katakana characters")
      end
      it 'firstname_kanaが全角漢字では登録できない' do
        @user.firstname_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana Input full-width katakana characters")
      end
      it 'lastname_kanaが全角ひらがなでは登録できない' do
        @user.lastname_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana Input full-width katakana characters")
      end
      it 'firstname_kanaが全角ひらがなでは登録できない' do
        @user.firstname_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana Input full-width katakana characters")
      end

    end
  end

end
