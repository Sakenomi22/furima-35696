class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :image
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :judgement_id
      validates :area_id
      validates :delivery_day_id
    end
    with_options inclusion: { in: 300..9_999_999, message: 'には300~9,999,999の数字を入力してください' }, format: { with: /\A[0-9]+\z/ } do
      validates :price
    end
  end
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :judgement
  belongs_to :delivery_day
  belongs_to :area
  belongs_to :user
  has_one :purchase
  has_one_attached :image
end
