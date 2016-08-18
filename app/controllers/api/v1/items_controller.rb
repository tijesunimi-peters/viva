module Api
  module V1
    class ItemsController < Api::ApisController
      before_action :get_bucketlist
      before_action :get_item, only: [:show, :update, :destroy]

      def create
        item = @bucketlist.items.create allowed_params
        render(json: item, status: 201) && return if item.errors.empty?
        render json: { error: "Record not created" }, status: 500
      end

      def index
        if @bucketlist
          render json: @bucketlist.items, key_transform: :underscore
        else
          render json: { error: "Bucketlist not found" }, status: 404
        end
      end

      def show
        render json: @item, key_transform: :underscore
      end

      def update
        if @item.update allowed_params
          render json: @item
        else
          render json: { error: "Error occured" }, status: 500
        end
      end

      def destroy
        @item.destroy
        render json: { success: "Item deleted" }
      end

      private

      def allowed_params
        params.permit(:name, :done)
      end

      def get_item
        @item = @bucketlist.items.find_by(id: params[:item_id])
        render(json: { error: "Item not found" }, status: 404) &&
          return unless @item
      end
    end
  end
end
