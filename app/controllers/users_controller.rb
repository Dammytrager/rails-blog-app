class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
    @show_footer = false
  end

  def show
    @show_footer = false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha blog #{@user.username}"
      redirect_to articles_path
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
      redirect_to articles_path
    else
      render :edit
    end
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

end