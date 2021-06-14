require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: user.id, product_id: product.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '出品ができる時' do
      it 'postal_code,area_id,city,number,tokenがあれば保存できる' do
        expect(@purchase_delivery).to be_valid
      end
      it 'postal_codeにハイフンがあれば出品できる' do
        @purchase_delivery.postal_code = '123-1234'
        expect(@purchase_delivery).to be_valid
      end
      it 'numberは11桁以内の数値であれば出品できる' do
        @purchase_delivery.number = '12345671234'
        expect(@purchase_delivery).to be_valid
      end
      it 'buildingは空でも出品できる' do
        @purchase_delivery.building = ''
        expect(@purchase_delivery).to be_valid
      end
    end
    context '保存ができない時' do
      it 'postal_codeが空だと出品できない' do
        @purchase_delivery.postal_code = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'area_idが空だと出品できない' do
        @purchase_delivery.area_id = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Area can't be blank")
      end
      it 'cityが空だと出品できない' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
      end
      it 'numberが空だと出品できない' do
        @purchase_delivery.number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Number can't be blank")
      end
      it 'user_idが空だと出品できない' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'product_idが空だと出品できない' do
        @purchase_delivery.product_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Product can't be blank")
      end
      it 'postal_codeにハイフンがなければ出品できない' do
        @purchase_delivery.postal_code = '1111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Postal code is invalid')
      end
      it 'numberは12桁以上だと出品できない' do
        @purchase_delivery.number = '111111111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Number is invalid')
      end
      it 'numberは9桁以下だと登録できない' do
        @purchase_delivery.number = '111111111'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Number is invalid")
      end
      it 'numberは数値じゃないと出品できない' do
        @purchase_delivery.number = 'あああ'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Number is invalid')
      end
      it 'tokenが空では出品できない' do
        @purchase_delivery.token = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it 'area_idが1だと登録できない' do
        @purchase_delivery.area_id = '1'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Area must be other than 1')
      end
    end
  end
end
