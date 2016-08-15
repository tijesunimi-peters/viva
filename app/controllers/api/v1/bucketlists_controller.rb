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
    payload = process_params(allowed_params[:bucketlist])
    if payload
      bktlist = current_user.bucketlists.create payload
      if bktlist.errors.empty?
        render json: { success: "Bucketlist Successfully created" }, status: 201
        return
      end
      render json: { error: "Error occured" }, status: 500
    else
      render json: { error: "Request not understood" }, status: 422
    end
  end

  def show
    if @bucketlist
      render json: @bucketlist, except: :items
    else
      render json: { error: "Bucketlist not found" }, status: 404
    end
  end

  def update
    if @bucketlist.update process_params allowed_params[:bucketlist]
      render json: { success: "Bucketlist Updated" }, status: 200
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
    params.permit(:bucketlist)
  end

  def get_bucketlists
    return if params[:limit] && params[:limit].to_i > 100
    query = params[:q]
    @bucketlists = query ? current_user.bucketlists.search(query) :
      current_user.bucketlists.paginate(params[:page].to_i, params[:limit].to_i)
  end
end
