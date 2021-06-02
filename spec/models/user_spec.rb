require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録ができる時' do
      it "nicknameとemail、passwordとpassword_confiramation,family_name,first_name,family_name_kana,first_name_kana,birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが６文字以上の半角英数字混合であれば登録できる" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        expect(@user).to be_valid
      end
      it "family_nameが全角文字であれば登録できる" do
        @user.family_name = "田中"
        expect(@user).to be_valid
      end
      it "first_nameが全角文字であれば登録できる" do
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end
      it "family_name_kanaが全角カナであれば登録できる" do
        @user.family_name_kana = "タナカ"
        expect(@user).to be_valid
      end
      it "first_name_kanaが全角カナであれば登録できる" do
        @user.first_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できない時' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank") 
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordは英数字混合でないと登録できない" do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空だと登録できない" do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "family_nameが全角でないと登録できない" do
        @user.family_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_nameが全角でないと登録できない" do
        @user.first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end
      it "family_name_kanaが空では登録できない" do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it "family_name_kanaが全角カナでないと登録できない" do
        @user.family_name_kana = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana 全角カナを使用してください")
      end
      it "firtst_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "first_name_kanaが全角カナでないと登録できない" do
        @user.first_name_kana = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カナを使用してください")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end


