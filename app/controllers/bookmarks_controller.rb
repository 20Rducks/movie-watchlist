class BookmarksController < ApplicationController
  # before_action :set_bookmark, only: :destroy
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  # def show
  #   search_query = params[:query]
  #   if search_query.present?

  #     sql_query = <<~SQL
  #       movie.title @@ :query
  #     SQL

  #     @bookmarks = @bookmarks.from(:movie).where(sql_query, query: "%#{params[:query]}%")

  #     if @bookmarks.empty?
  #       flash.now[:alert] = "No bookmark found for '#{search_query}'. Please search again."
  #     end

  #   else
  #     @bookmarks = @list.bookmarks
  #   end
  # end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
