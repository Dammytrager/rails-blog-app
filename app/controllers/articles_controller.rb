class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.paginate(page: params[:page]).order(created_at: :desc)
    @show_footer = false
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.create(article_params.merge({user: current_user}))

    if @article.errors&.full_messages.empty?
      flash[:notice] = 'Articles created successfully'
      redirect_to articles_path
    else
      render new_article_path
    end
  end

  def update
    @article.update(article_params)

    if @article.errors&.full_messages.empty?
      flash[:notice] = 'Articles updated successfully'
      redirect_to @article
    else
      render 'articles/edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article deleted successfully"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :description)
  end


end
