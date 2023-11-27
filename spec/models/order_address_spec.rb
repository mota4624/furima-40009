require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user:)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '購入情報に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postalcodeが空だと保存できないこと' do
        @order_address.postalcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postalcode can't be blank")
      end
      it 'postalcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postalcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postalcode is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_address.prefecture = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'housenumberが空だと保存できないこと' do
        @order_address.housenumber = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Housenumber can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが10桁未満だと保存できないこと' do
        @order_address.phone = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is too short')
      end
      it 'phoneが11桁を超過すると保存できないこと' do
        @order_address.phone = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is too long')
      end
      it 'phoneが半角数値のみでないと保存できないこと' do
        @order_address.phone = '090-1234-56'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone is invalid. Input only number')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
