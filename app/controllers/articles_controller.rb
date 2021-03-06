class ArticlesController < ApplicationController
  require 'open-uri'
  before_action :set_params, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show, :search, :tag_index]
  before_action :stock_news, only: [:index, :tag_index, :search]

  def index
    @articles = Article.page(params[:page]).order("created_at DESC")
    include = ArticlesHelper
  end

  def tag_index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @articles = @tag.articles.page(params[:page]).order("created_at DESC")
    else
      @articles = Article.page(params[:page]).order("created_at DESC")
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_tag_params)
    if @article.save
      tag_list = tag_params[:name].split(/[[:blank:]]+/).select(&:present?)#空白で区切る
      @article.save_tags(tag_list)
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
  end

  def edit
    unless @article.id == current_user.id
      redirect_to root_path
    end
    @tag_list = @article.tags.pluck(:name)
  end

  def update
    if @article.update(article_tag_params)  
       tag_list = tag_params[:name].split(/[[:blank:]]+/).select(&:present?)#空白で区切る  
       @article.save_tags(tag_list)
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @articles = Article.joins(:tags)
    @keywords = params[:keyword].split(/[[:blank:]]+/)
    keywords = @keywords.map do |keyword|
      @articles.where("title LIKE(:keyword) OR content LIKE(:keyword) OR tags.name LIKE(:keyword)", keyword: "%#{keyword}%")
    end
    @articles = @articles.merge(keywords[0])
    keywords[1, keywords.length].each do |keyword|
      @articles = @articles.or(keyword)
    end
    @articles = @articles.page(params[:page]).order("created_at DESC")
  end


  private

  def set_params
    @article = Article.find(params[:id])
  end

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
