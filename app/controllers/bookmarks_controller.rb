class BookmarksController < ApplicationController
  before_action :set_list, only: %w[new create]
  before_action :set_bookmark, only: %w[edit update destroy]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.movie = Movie.find(params[:bookmark][:movie_id])
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @bookmark.update(bookmark_params)
    @list = @bookmark.list
    redirect_to list_path(@list)
  end

  def destroy
    @bookmark.destroy
    @list = @bookmark.list
    redirect_to list_path(@list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
