require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:product_ids) }
  it { should belong_to(:user) }
  it { should serialize(:product_ids) }
end
