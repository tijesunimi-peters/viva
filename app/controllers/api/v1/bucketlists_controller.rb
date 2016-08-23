module Api
  module V1
    class BucketlistsController < Api::ApisController
      before_action :get_bucketlist, only: [:show, :update, :destroy]
      before_action :get_bucketlists, only: [:index]

      def index
        if params[:limit] && params[:limit].to_i > 100
          render json: { error: msg[:limit_exceeded] },
                 status: 413
          return
        end

        render json: @bucketlists, key_transform: :underscore
      end

      def create
        bucketlist = current_user.bucketlists.create allowed_params
        if bucketlist.errors.empty?
          render json: bucketlist, status: :created and return
        end
        render json: { error: bucketlist.errors.full_messages },
               status: :internal_server_error
      end

      def show
        if @bucketlist
          render json: @bucketlist, except: :items
        else
          render json: { error: msg("Bucketlist")[:not_found] },
                 status: :not_found
        end
      end

      def update
        if @bucketlist.update allowed_params
          render json: @bucketlist, status: :ok
        else
          render json: { error: msg[:error_occured] },
                 status: :internal_server_error
        end
      end

      def destroy
        if @bucketlist.destroy
          render json: { success: msg("Bucketlist")[:deleted] }, status: :ok
        else
          render json: { error: msg[:error_occured] },
                 status: :internal_server_error
        end
      end

      private

      def allowed_params
        params.permit(:id, :name)
      end

      def get_bucketlists
        return if params[:limit] && params[:limit].to_i > 100
        query = params[:q]

        if query
          @bucketlists = current_user.bucketlists.search(query)
        else
          @bucketlists = current_user.bucketlists.paginate(
            params[:page].to_i,
            params[:limit].to_i
          )
        end
      end
    end
  end
end
