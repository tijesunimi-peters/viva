module Api
  module V1
    class BucketlistsController < Api::ApisController
      before_action :get_bucketlist, only: [:show, :update, :destroy]
      before_action :get_bucketlists, only: [:index]

      def index
        render(json: @bucketlists, key_transform: :underscore) &&
        return if @bucketlists
        render json: { error: msg[:limit_exceeded] }, status: 413
      end

      def create
        bucketlist = current_user.bucketlists.create allowed_params
        if bucketlist.errors.empty?
          render(json: bucketlist, status: :created) && return
        end
        render json: { error: bucketlist.errors.full_messages },
               status: :internal_server_error
      end

      def show
        render json: @bucketlist, except: :items
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
        @bucketlist.destroy
        render json: { success: msg("Bucketlist")[:deleted] }, status: :ok
      end

      private

      def allowed_params
        params.permit(:id, :name)
      end

      def get_bucketlists
        query = params[:q]

        if query
          @bucketlists = current_user.bucketlists.search(query)
        else
          @bucketlists = current_user.bucketlists.paginate(
            params[:page],
            params[:limit]
          )
        end
      end
    end
  end
end
