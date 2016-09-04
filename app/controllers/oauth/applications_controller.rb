class Oauth::ApplicationsController < ApplicationController
  include UserUtilities
  before_action :current_user
  before_action :get_app, only: [:show, :update, :destroy, :edit]

  def index
    @applications = @user.oauth_applications
  end

  def new
    @application = @user.oauth_applications.new
  end

  def create
    if app.save
      flash[:success] = msg("App creation")[:successful]
      redirect_to oauth_application_url(app) && return
    end
    @application = app
    render :new
  end

  def show
  end

  def edit
  end

  def update
    if @application.update app_params
      flash[:success] = msg("App update")[:successful]
      redirect_to oauth_application_url(@application)
    else
      render :edit
    end
  end

  def destroy
    @application.destroy
    flash[:success] = msg("App delete")[:successful]
    redirect_to oauth_applications_url
  end

  private

  def app_params
    params.require(:doorkeeper_application).permit :name,
                                                   :redirect_uri,
                                                   :scopes
  end

  def get_app
    @application = @user.oauth_applications.find_by(id: params[:id])
  end

  def app
    app = Doorkeeper::Application.new app_params
    app.owner = @user if Doorkeeper.configuration.confirm_application_owner?
    app
  end
end
