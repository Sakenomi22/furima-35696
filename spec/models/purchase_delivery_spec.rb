require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: @user.id, product_id: @product.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '保存ができる時' do
      it 'postal_code,area_id,city,number,tokenがあれば保存できる' do
        expect(@purchase_delivery).to be_valid
      end
      it 'postal_codeにハイフンがあれば保存できる' do
        @purchase_delivery.postal_code = '123-1234'
        expect(@purchase_delivery).to be_valid
      end
      it 'numberは11桁以内の数値であれば保存できる' do
        @purchase_delivery.number = '12345671234'
        expect(@purchase_delivery).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @purchase_delivery.building = ''
        expect(@purchase_delivery).to be_valid
      end
    end
    context '保存ができない時' do
      it 'postal_codeが空だと保存できない' do
        @purchase_delivery.postal_code = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'area_idが空だと保存できない' do
        @purchase_delivery.area_id = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Area can't be blank")
      end
      it 'cityが空だと保存できない' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
      end
      it 'numberが空だと保存できない' do
        @purchase_delivery.number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Number can't be blank")
      end
      it 'user_idが空だと保存できない' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'product_idが空だと保存できない' do
        @purchase_delivery.product_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Product can't be blank")
      end
      it 'postal_codeにハイフンがなければ保存できない' do
        @purchase_delivery.postal_code = '1111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Postal code is invalid')
      end
      it 'numberは11桁以内でないと保存できない' do
        @purchase_delivery.number = '111111111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Number is invalid')
      end
      it 'numberは数値じゃないと登録できない' do
        @purchase_delivery.number = 'あああ'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Number is invalid')
      end
      it 'tokenが空では登録できない' do
        @purchase_delivery.token = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
