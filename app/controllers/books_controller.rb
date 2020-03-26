class BooksController < ApplicationController
	before_action :authenticate_user!, except: :top
	before_action :correct_user, only: [:edit, :update]
	def top
	end

	def index
		@book = Book.new
		@books = Book.all
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render :index
		end
	end

	def show
		@new_book = Book.new
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def correct_user
  		book = Book.find(params[:id])
  		user = book.user_id
    	unless user == current_user.id
      		redirect_to books_path
    	end
	end

	private
		def book_params
			params.require(:book).permit(:title, :body)
		end

end
