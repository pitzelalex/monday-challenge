class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = 'No user registered with that email'
      render :login_form
    elsif user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to root_path
    else
      flash[:error] = 'Invalid password'
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_not_found(exception)
    flash[:error] = exception.message
    render :login_form
  end
end
