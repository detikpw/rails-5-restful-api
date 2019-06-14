class Purchase < ApplicationRecord
  belongs_to :user
  validates_presence_of :product_ids, :user_id, :total_price
  serialize :product_ids, Array

  before_validation :set_total_price, on: :create

  def set_total_price
    self.total_price = product_ids.reduce(0) { |total_price, product_id | total_price + Product.find(product_id).price } if attribute_present?("product_ids")
  end


end
