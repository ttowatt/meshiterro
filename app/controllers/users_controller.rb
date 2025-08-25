class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update]
before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
end

def update
  if @user.update(user_params)
    redirect_to user_path(@user.id)
  else
    render :edit
  end
end

private

def set_user
  @user = User.find_by(id: params[:id])
end

def ensure_correct_user
  if @user.nil? || @user.id != current_user.id
    redirect_to post_images_path
  end
end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
  user = User.find_by(id: params[:id])
  if user.nil? || user.id != current_user.id
    redirect_to post_images_path
  end
end

end
