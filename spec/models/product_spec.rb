require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '新規商品出品' do
    context '出品できる時' do
      it 'imageとnameとdescriptionとcategoryとstatusとjudgementとareaとdelivery_dayとpriceがあれば投稿できる' do
        expect(@product).to be_valid
      end
      it 'priceが半角数字の300~9,999,999の間であれば投稿できる' do
        @product.price = '300'
      end
    end
    context '出品できない時' do
      it 'imageが空だと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと出品できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空だと出品できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが空だと出品できない' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが空だと出品できない' do
        @product.status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Status can't be blank")
      end
      it 'judgement_idが空だと出品できない' do
        @product.judgement_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Judgement can't be blank")
      end
      it 'area_idが空だと出品できない' do
        @product.area_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Area can't be blank")
      end
      it 'delivery_day_idが空だと出品できない' do
        @product.delivery_day_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery day can't be blank")
      end
      it 'priceが空だと出品できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字でないと出品できない' do
        @product.price = "あああ"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price には300~9,999,999の数字を入力してください")
      end
      it 'priceが300円未満だと出品できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price には300~9,999,999の数字を入力してください")
      end
      it 'priceが10,000,000円以上だと出品できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price には300~9,999,999の数字を入力してください")
      end
      it 'category_idが1だと登録できないこと' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category must be other than 1")
      end
      it 'status_idが1だと登録できないこと' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Status must be other than 1")
      end
      it 'judgement_idが1だと登録できないこと' do
        @product.judgement_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Judgement must be other than 1")
      end
      it 'area_idが1だと登録できないこと' do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Area must be other than 1")
      end
      it 'delivery_day_idが1だと登録できないこと' do
        @product.delivery_day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery day must be other than 1")
      end
    end
  end
end