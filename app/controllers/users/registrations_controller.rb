class Users::RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def user_params
    params.require(:user).permit(:image, :email, :password, :password_confirmation, :name, keys: [:current_password])
  end
end
