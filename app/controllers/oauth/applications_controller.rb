class Oauth::ApplicationsController < ApplicationController
  include UserUtilities
  before_action :current_user
  before_action :get_app, only: [:show, :update, :destroy, :edit]

  def index
    @applications = @user.oauth_applications
  end

  def new
    @app = @user.oauth_applications.new
  end

  def create
    @app = Doorkeeper::Application.new app_params
    @app.owner = @user if Doorkeeper.configuration.confirm_application_owner?
    if @app.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@app)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @application.update app_params
      redirect_to oauth_application_url(@application)
    else
      render :edit
    end
  end

  def destroy
    @application.destroy
    redirect_to oauth_applications_url
  end

  private

  def app_params
    params.require(:doorkeeper_application).permit :name,
      :redirect_uri,
      :scopes
  end

  def get_app
    @application = @user.oauth_applications.find_by id: params[:id]
  end
end
