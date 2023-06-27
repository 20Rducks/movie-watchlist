class ListsController < ApplicationController
  before_action :set_list, only: %i[show destroy]

  def index
    @lists = List.all
    @list = List.new

    search_query = params[:query]
    if search_query.present?

      sql_query = <<~SQL
        name @@ :query
      SQL
      @lists = List.where(sql_query, query: "%#{params[:query]}%")
      if @lists.empty?
        flash.now[:alert] = "No lists found for '#{search_query}'. Please search again."
      end
    else
      @lists = List.all
    end
    @lists = @lists.sort_by(&:created_at)
  end

  def show
    @bookmark_new = Bookmark.new
    @bookmarks = @list.bookmarks
    @review = Review.new(list: @list)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save!
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end



  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
