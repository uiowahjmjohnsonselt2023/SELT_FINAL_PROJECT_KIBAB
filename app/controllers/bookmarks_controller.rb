# frozen_string_literal: true

class BookmarksController < ApplicationController

  before_action :set_current_user
  before_action :set_current_shopping_cart

  def bookmark_params
    params.permit(:id)
  end

  def index
    Bookmark.where(user_id: @current_user.id).each do |item|
      if item.product.is_sold.eql? true
        flash[:notice] = "#{item.product.name} was sold."
        Bookmark.destroy(item)
      end
    end
    @current_bookmarks = Bookmark.where(user_id: @current_user.id)
  end

  def edit
  end

  def destroy
    Bookmark.destroy(Bookmark.where(user_id: @current_user.id))
    redirect_to products_path
  end

  def delete_one
    if bookmark_params[:id].present?
      @current_bookmark = bookmark_params[:id]
      Bookmark.destroy(@current_bookmark)
      flash[:notice] = "Bookmark deleted."
      redirect_to view_bookmarks_path
    else
      flash[:notice] = "Could not delete #{@current_bookmark.product.name}."
    end
  end
end
