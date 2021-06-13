class Delivery < ApplicationRecord
  attr_accessor :token

  belongs_to :purchase
end
