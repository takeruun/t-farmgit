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
	   @user = User.find_by(id: current_user.id)
	   super
	   if params[:user][:image]
	   	@user.image = params[:user][:image]
	   	@user.save
	   	flash[:notice] = "画像編集しました"
	   end
	end

	def destroy
		super
	end

	protected
     def user_params
       params.require(:user).permit(:image, :email, :password ,:password_confirmation, :name, keys: [:current_password] )
     end
end