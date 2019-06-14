class Product < ApplicationRecord
    validates_presence_of :name, :slug, :price
    before_validation :create_slug

    # TODO search use any part of word
    searchkick

    private
    def create_slug
        self.slug ||= name.parameterize if attribute_present?("name")
    end
end
