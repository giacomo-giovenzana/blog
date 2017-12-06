class ArticlesController < ApplicationController
  def new
    @article = Article.new()
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(whitelist_article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    # render plain: params.inspect
    # <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"c5GnbBveaz1qbcrXfcIshz9lccf6Pxr82W1yt0RqJdCrLwT5hdzHX+CMM01osF+gYpj22XXth1Bs4ht7F55dig==", "article"=>{"title"=>"pippo", "text"=>"pluto"}, "commit"=>"Create", "controller"=>"articles", "action"=>"create"} permitted: false>
    @article = Article.new(whitelist_article_params)
    if @article.save
      # render plain: @article.inspect
      # #<Article id: 1, title: "pippo", text: "pluto", created_at: "2017-12-05 17:00:41", updated_at: "2017-12-05 17:00:41">
      redirect_to @article # call the articles/:id so the show action is called
    else
      # render plain: @article.errors.inspect
      #<ActiveModel::Errors:0x0055cce7687b30 @base=#<Article id: nil, title: "", text: "", created_at: nil, updated_at: nil>, @messages={:title=>["can't be blank", "is too short (minimum is 3 characters)"], :text=>["can't be blank", "is too short (minimum is 3 characters)"]}, @details={:title=>[{:error=>:blank}, {:error=>:too_short, :count=>3}], :text=>[{:error=>:blank}, {:error=>:too_short, :count=>3}]}>
      render 'new' # call directly the page new. redirect_to recall the http endpoint articles#new. With render the @article var is correctly passed to the view 'new'.If I have used redirect_to here a new call to articles#new is done.
    end
  end

  def show
    # render plain: params.inspect
    # <ActionController::Parameters {"controller"=>"articles", "action"=>"show", "id"=>"2"} permitted: false>
    @article = Article.find(params[:id])
    # render plain: @article.inspect
    # #<Article id: 2, title: "pippo", text: "pluto", created_at: "2017-12-05 17:15:06", updated_at: "2017-12-05 17:15:06">
  end

  def index
    @articles = Article.all()
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
    def whitelist_article_params()
      params.require(:article).permit(:title, :text)
    end
end
