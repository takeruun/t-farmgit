class Users::SessionsController < Devise::SessionsController
	def new
		super
		if user_signed_in? != true
			flash[:notice] = "パスワードかメールアドレスが間違ってます"
		end
	end

	def create
		super		
	end

	def destroy
		super
	end

end
