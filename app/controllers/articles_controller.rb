class ArticlesController < ApplicationController
  def index
    if params[:search]
      @articles = Article.search(params[:search]).sort_by(&:_score).reverse!.last(10)
      puts @articles
    else
      @articles = []
    end
    render template: "../views/layouts/articles/index.html.erb"
  end
end