# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :require_user!
  def index
    client = Twitter::TwitterClient.new(current_user)
    @authors = {}
    @bookmarks = nil
    if client.bookmarks[:data].present?
      _bookmarks = client.bookmarks[:includes][:users]
      _bookmarks.each do |user|
        @authors[user[:id]] = user
      end
      @bookmarks = client.bookmarks[:data]
      @folders = {}
      @bookmarks.each do |bookmark|
        bookmark.fetch(:context_annotations, []).each do |annotation|
          key = context_annotation_key(annotation)
          @folders[key] = "#{annotation[:entity][:name]}"
        end
      end
      if params[:folder].present?
        filter_by_folder
      end
    else
      # calling response message from response message file whi
      render json: { message: ResponseMessages::NO_BOOKMARKS_FOUND}, status: :not_found
    end
    
    
  end


  private

  def context_annotation_key(annotation)
    [annotation[:domain][:id],annotation[:entity][:id]].join('-')
  end

  def filter_by_folder
   # here it will filter the bookmarks by folder and show only the bookmarks of that folder
    new_bookmarks = [] 
    @bookmarks.each do |bookmark|
      bookmark.fetch(:context_annotations, []).each do |annotation|
        key = context_annotation_key(annotation)
        if key == params[:folder]
          new_bookmarks << bookmark
        end
      end
    end
    @bookmarks = new_bookmarks
  end
end
