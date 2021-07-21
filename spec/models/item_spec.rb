require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/test_image.png')
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it 'image,product_name,describe,category,status,burden,delivery,days_delivary,praceが入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it '商品画像が1枚もないときは出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品カテゴリーが空では出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank ")
      end
      it '商品カテゴリー1が選択されている時は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank ")
      end
      it '商品状態が空では出品できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank ")
      end
      it '商品状態1が選択されている時は出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank ")
      end
      it '配送料負担の情報が空では出品できない' do
        @item.burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden can't be blank ")
      end
      it '配送料負担1が選択されている時は出品できない' do
        @item.burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden can't be blank ")
      end
      it '発送元地域が空では出品できない' do
        @item.delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery can't be blank ")
      end
      it '発送元地域1が選択されている時は出品できない' do
        @item.delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery can't be blank ")
      end
      it '発送までの日数が空では出品できない' do
        @item.days_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Days delivery can't be blank ")
      end
      it '発送までの日数1が選択されている時は出品できない' do
        @item.days_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Days delivery can't be blank ")
      end
      it '価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格は¥300より下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '価格は¥1000万以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '価格は全角では出品できない' do
        @item.price = '１２３４'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '価格は半角英語では出品できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '価格は半角英数混合では出品できない' do
        @item.price = '1a1a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it 'ユーザー情報が空では出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
