class UsersController < ApplicationController

	def new
  @user = User.new
end

def create
      
      @user = User.new(user_params)
      
      if @user.save
        
        user = User.find_by(email: @user.email)
        if user && user.authenticate(@user.password)
          sign_in(user)
          redirect_to root_path
        else
          render :new
        end
        
      else
        render :new
      end
    end
private
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end


end
