class ArticlesController < ApplicationController
  require 'open-uri'
  
  before_action :stock_news

  def index
  end


  private

  def stock_news
    api = Rails.application.credentials.news_api[:api_key]
    uri = "https://newsapi.org/v2/everything?q=%E6%A0%AA%E4%BE%A1&sortBy=popularity&apiKey=#{api}"
    req = open(uri)
    article_serialized = open(uri).read
    @article_news = JSON.parse(article_serialized) 
  end

end
