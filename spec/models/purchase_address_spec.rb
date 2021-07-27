require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品の購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('app/assets/images/test_image.png')
      @item.save
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context '商品の購入ができる' do
      it '適切な情報が入力されていれば購入ができる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameは空でも購入ができる' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '商品の購入ができない' do
      it 'postal_codeが空では購入できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角文字列のみでは購入できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'psotal_codeが「3桁ハイフン4桁以外」では購入できない' do
        @purchase_address.postal_code = '12-345678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'delivery_idが空では購入できない' do
        @purchase_address.delivery_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Delivery can't be blank")
      end
      it 'delivery_idが1では購入できない' do
        @purchase_address.delivery_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Delivery can't be blank")
      end
      it 'municipalityが空では購入できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空では購入できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁未満では購入できない' do
        @purchase_address.phone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase_address.phone_number = '090123456789'
      end
      it 'phone_numberが全角では購入できない' do
        @purchase_address.phone_number = '１２３４５６７８９０'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが半角英語では購入できない' do
        @purchase_address.phone_number = 'abcdefghijk'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが半角英数混合では購入できない' do
        @purchase_address.phone_number = '090abcd1234'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberに記号が含まれていると購入できない' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'usre_idが空では購入できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
