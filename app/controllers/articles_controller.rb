class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]


  def index
    @articles = Article.order('created_at DESC')
    @rows = [[]]
    @articles.each do |article|
      if @rows[-1].length < 3
        @rows[-1] << article
      else
        @rows << []
        @rows[-1] << article
      end
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
     if @article.save
       redirect_to article_path(@article)
     else
       render :new
     end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image, :remove_image, :image_cache)
  end

  def set_article
    @article = Article.find(params[:id])
  end


end
