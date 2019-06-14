class PurchaseController < ApplicationController
    def create
        purchase = Purchase.create!(
            user_id: @current_user.id,
            product_ids: params[:product_ids]
        )
        response = { message: Message.purchase_created, id: purchase.id }
        json_response(response, :created)
    end
end
