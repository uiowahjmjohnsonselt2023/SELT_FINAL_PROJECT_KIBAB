# frozen_string_literal: true

class BookmarksController < ApplicationController

  before_action :set_current_user

  def index
    @current_bookmarks = Bookmark.where(user_id: @current_user.id)
  end

  def edit
  end

  def destroy
    Bookmark.destroy(Bookmark.where(user_id: @current_user.id))
  end

end
