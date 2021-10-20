class UsersController < ApplicationController
  include Authable

  before_action :require_login, except: [:index, :new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]

  def index
    @users = User.all.paginate(page: params[:page]).order(created_at: :desc)
  end

  def new
    @user = User.new
    @show_footer = false
  end

  def show
    @articles = @user.articles.paginate(page: params[:page])
    @show_footer = false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha blog #{@user.username}"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @show_footer = false
  end

  def update
    @user.update(user_params)
    if @user.errors&.full_messages.empty?
      flash[:notice] = 'User updated successfully'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = 'Account and associated articles deleted successfully'
    redirect_to articles_path
  end

  private

  def user_params
    fields = [:username, :email, :password]
    fields = fields | [:password_confirmation] if action_name.to_sym == :create
    params.require(:user).permit(*fields)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user?
    if !@user.is?(current_user) && !current_user.user_type_admin?
      flash[:error] = 'You cannot change another user\'s profile'
      redirect_to current_user
    end
  end

end