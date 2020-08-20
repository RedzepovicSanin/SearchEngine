class ArticlesController < ApplicationController
  def index

    ### usage in tests since records doesnt exist.. 
    ### uncomment before running tests
    # @articles = Article.search(params[:search])
    # render json: @articles

    ### usage in rendering template
    ### comment before running tests
    if params[:search]
      @articles = Article.search(params[:search]).sort_by(&:_score).reverse!.last(10)
    else
      @articles = []
    end
    render template: "../views/layouts/articles/index.html.erb"

  end
end