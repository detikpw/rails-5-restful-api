require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:product_ids) }
  it { should belong_to(:user) }
  it { should serialize(:product_ids) }

  let(:user) { create(:user) }
  let(:products) { create_list(:product, 3, price: 10_000) }
  let(:sample_purchase) { described_class.new(
    user_id: user.id,
    product_ids: products.map(&:id)
  )}


  context "when create purchase" do
    before { sample_purchase.valid? }
    let(:result) {30_000}
    it 'gets created' do
      expect(sample_purchase.total_price).to  eq(result)
    end
  end
end
