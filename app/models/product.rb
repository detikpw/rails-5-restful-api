class Product < ApplicationRecord
    validates_presence_of :name, :slug
    before_validation :create_slug

    private
    def create_slug
        self.slug ||= name.parameterize if attribute_present?("name")
    end
end
