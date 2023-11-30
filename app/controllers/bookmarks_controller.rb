# frozen_string_literal: true

class BookmarksController < ApplicationController

  before_action :set_current_user

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

end
