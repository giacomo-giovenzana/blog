class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(whitelist_comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    #render plain: params.inspect
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def whitelist_comment_params()
      params.require(:comment).permit(:commenter, :body)
    end
end
