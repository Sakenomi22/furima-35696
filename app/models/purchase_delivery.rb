class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :city, :block, :building, :number, :user_id, :product_id, :token

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :city
    validates :block
    validates :token
    with_options format: { with: /\A\d{3}-\d{4}\z/ } do
      validates :postal_code
    end
    with_options format: { with: /\A\d{10,11}\z/ } do
      validates :number
    end
    validates :area_id, numericality: { other_than: 1 }
  end

  def save
    purchase = Purchase.create(user_id: user_id, product_id: product_id)
    Delivery.create(postal_code: postal_code, area_id: area_id, city: city, block: block, building: building, number: number,
                    purchase_id: purchase.id, token: token)
  end
end
