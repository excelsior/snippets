class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    snippet_params = params.require(:snippet).permit(:body)
    @snippet = Snippet.new(snippet_params)

    if @snippet.save
      redirect_to @snippet, notice: 'Snippet was created successfully.'
    else
      render :new
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end
end
