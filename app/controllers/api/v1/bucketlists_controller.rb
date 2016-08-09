class Api::V1::BucketlistsController < Api::ApisController
  def all
    render json: Bucketlist.all
  end

  def create
    if process_params
      bktlist = current_user.bucketlists.create process_params
      if bktlist.errors.empty?
        render json: { success: "Bucketlist Successfully created" }, status: 201
        return
      end
      render json: { error: "Error occured" }, status: 500
    else
      render json: { error: "Request not understood" }, status: 422
    end
  end

  private

  def allowed_params
    params.permit(:bucketlist)
  end

  def process_params
    begin
      JSON.parse allowed_params[:bucketlist]
    rescue
      false
    end
  end
end
