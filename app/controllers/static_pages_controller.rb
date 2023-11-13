# frozen_string_literal: true

require 'flickr'

class StaticPagesController < ApplicationController
  def home
    flickr = Flickr.new(ENV['FLICKR_KEY'], ENV['FLICKR_SECRET'])
    return if params[:user_id].nil?

    begin
      Rails.logger.info("User id: #{params[:user_id]}")

      responses = flickr.photos.search(user_id: params[:user_id])
      @photos = responses.map do |rsp|
        "https://live.staticflickr.com/#{rsp.server}/#{rsp.id}_#{rsp.secret}.jpg"
      end
    rescue StandardError => e
      flash[:alert] = e.message
    end
  end
end
