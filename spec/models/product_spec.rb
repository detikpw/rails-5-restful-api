require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  let(:sample_product) { described_class.new(name: 'Hello bro')}

  before { sample_product.valid? }

  context "when slug is missing" do

    let(:result) {'hello-bro'}
    it 'gets created' do
      expect(sample_product.slug).to  eq(result)
    end
  end
end
