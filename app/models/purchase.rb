class Purchase < ApplicationRecord
  belongs_to :user
  validates_presence_of :total_price, :product_ids, :user_id
  serialize :product_ids, Array
end
