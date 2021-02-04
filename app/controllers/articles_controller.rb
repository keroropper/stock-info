class ArticlesController < ApplicationController
  require 'open-uri'
  
  before_action :stock_news

  def index
    @articles = Article.page(params[:page]).order("created_at DESC")
    include = ArticlesHelper
  end

  def new
    @article = Article.new
  end

  def create
    # binding.pry
    @article = Article.new(article_tag_params)
    if @article.save
      tag_list = tag_params[:name].split(/[[:blank:]]+/).select(&:present?)#空白で区切る
      @article.save_tags(tag_list)
      redirect_to root_path
    else
      render action: :new
    end
  end


  private

  def article_tag_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id,
       images: params[:article][:images], content: params[:stockapp][:content])
  end

  def tag_params
    params.require(:article).permit(:name)
  end

  def stock_news
    api = Rails.application.credentials.news_api[:api_key]
    uri = "https://newsapi.org/v2/everything?q=%E6%A0%AA%E4%BE%A1&sortBy=popularity&apiKey=#{api}"
    req = open(uri)
    article_serialized = open(uri).read
    @article_news = JSON.parse(article_serialized) 
  end

end
