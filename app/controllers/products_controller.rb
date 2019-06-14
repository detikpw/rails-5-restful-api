class ProductsController < ApplicationController

    def index
        @products = Product.all
        json_response(@products)
    end

    def search
        products = Product.search params[:q]
        json_response(products)
    end
end
