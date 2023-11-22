require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報の保存' do
    context '商品情報の保存ができる場合' do
      it 'mage、itemname、description、category_id、condition_id、shippingfee_id、shippingorigin_id、deliverytime_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品情報の保存ができない場合' do
      it 'imageがなければ保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'itemnameがなければ保存できない' do
        @item.itemname = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Itemname can't be blank")
      end

      it 'descriptionがなければ保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが1なら保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが1なら保存できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'shippingfee_idが1なら保存できない' do
        @item.shippingfee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingfee can't be blank")
      end

      it 'shippingorigin_idが1なら保存できない' do
        @item.shippingorigin_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingorigin can't be blank")
      end

      it 'deliverytime_idが1なら保存できない' do
        @item.deliverytime_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Deliverytime can't be blank")
      end

      it 'priceがなければ保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceは299以下では保存できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceは全角では保存できない' do
        @item.price = '２９９'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
