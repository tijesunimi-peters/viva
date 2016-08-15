class Api::V1::BucketlistsController < Api::ApisController
  before_action :get_bucketlist, only: [:show, :update, :destroy]
  before_action :get_bucketlists, only: [:all]

  def all
    if params[:limit] && params[:limit].to_i > 100
      render json: { error: "Maximum result per request is 100" }, status: 413
      return
    end

    render json: @bucketlists, key_transform: :underscore
  end

  def create
    bucketlist = current_user.bucketlists.create allowed_params
    if bucketlist.errors.empty?
      render json: bucketlist, status: 201
      return
    end
    render json: bucketlist.errors.full_messages, status: 500
  end

  def show
    if @bucketlist
      render json: @bucketlist, except: :items
    else
      render json: { error: "Bucketlist not found" }, status: 404
    end
  end

  def update
    if @bucketlist.update allowed_params
      render json: @bucketlist, status: 200
    else
      render json: { error: "Error occured" }, status: 500
    end
  end

  def destroy
    if @bucketlist.destroy
      render json: { success: "Bucketlist Deleted" }, status: 200
    else
      render json: { error: "Error Occured" }, status: 500
    end
  end

  private

  def allowed_params
    params.permit(:id, :name)
  end

  def get_bucketlists
    return if params[:limit] && params[:limit].to_i > 100
    query = params[:q]
    @bucketlists = query ? current_user.bucketlists.search(query) :
      current_user.bucketlists.paginate(params[:page].to_i, params[:limit].to_i)
  end
end
