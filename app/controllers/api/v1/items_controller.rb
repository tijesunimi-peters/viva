class Api::V1::ItemsController < Api::ApisController
  before_action :get_bucketlist
  before_action :get_item, only: [:show, :update, :destroy]

  def create
    if @bucketlist
      bktlist = @bucketlist.items.create process_params(allowed_params[:item])
      if bktlist.errors.empty?
        render json: { success: "Item created for #{@bucketlist.name}" },
          status: 201
      else
        render json: { error: "Error occured" }, status: 500
      end
    else
      render json: { error: "Bucketlist not found" }, status: 404
    end
  end


  def all
    render json: @bucketlist.items, key_transform: :underscore
  end

  def show
    if @item
      render json: @item, key_transform: :underscore
    else
      render json: { error: "Item not found" }, status: 404
    end
  end

  def update
    if @item
      if @item.update process_params(allowed_params[:item])
        render json: { success: "Item updated" }
        return
      else
        render json: { error: "Error occured" }, status: 500
        return
      end
    else
      render json: { error: "Item not found" }, status: 404
    end
  end

  def destroy
    if @item
      @item.destroy
      render json: { success: "Item deleted" }
    else
      render json: { error: "Item not found" }, status: 404
    end
  end

  private

  def allowed_params
    params.permit(:item)
  end

  def get_item
    @item = @bucketlist.items.find_by(id: params[:item_id])
  end
end
