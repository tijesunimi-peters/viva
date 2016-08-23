module Api
  module V1
    class ItemsController < Api::ApisController
      before_action :get_bucketlist
      before_action :get_item, only: [:show, :update, :destroy]

      def create
        item = @bucketlist.items.create allowed_params
        render json: item, status: :created and return if item.errors.empty?
        render json: { error: item.errors.full_messages },
               status: :internal_server_error
      end

      def index
        if @bucketlist
          render json: @bucketlist.items, key_transform: :underscore
        else
          render json: { error: msg("Bucketlist")[:not_found] }, status: :not_found
        end
      end

      def show
        render json: @item, key_transform: :underscore
      end

      def update
        if @item.update allowed_params
          render json: @item
        else
          render json: { error: msg[:error_occured] },
                 status: :internal_server_error
        end
      end

      def destroy
        @item.destroy
        render json: { success: msg("Item")[:deleted] }
      end

      private

      def allowed_params
        params.permit(:name, :done)
      end

      def get_item
        @item = @bucketlist.items.find_by(id: params[:item_id])
        render json: { error: msg("Item")[:not_found] },
               status: :not_found and
        return unless @item
      end
    end
  end
end
