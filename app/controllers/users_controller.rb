class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def index
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.id = current_user.id
		if @user.update(user_params)
			flash[:notice] = "You have creatad book successfully."
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end
	def correct_user
    	unless User.find(params[:id]) == current_user
      		redirect_to user_path(current_user.id)
      	end
    end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
end


