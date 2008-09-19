class UsersController < ApplicationController
  before_filter :login_required

  before_filter :set_pagetitle
  
  def set_pagetitle
    @pagetitle = 'user admin'
  end
  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
  
  def edit
    @user = User.find(params[:id])
  end
   
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'user successfully updated'
      redirect_to(user_path(@user))
    else
      render :action => 'edit'
    end
  end
  
  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

end
