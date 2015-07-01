class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.only_public

    if @query = params[:q]
      @query.downcase!
      @snippets.where!("LOWER(body) LIKE ?", "%#{@query}%")
    end

    @snippets = @snippets.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    snippet_params = params.require(:snippet).permit(:body, :private)
    @snippet = Snippet.new(snippet_params)

    if @snippet.save
      redirect_to @snippet, notice: 'Snippet was created successfully.'
    else
      render :new
    end
  end

  def show
    @snippet = Snippet.find_by_slug(params[:id]) || Snippet.only_public.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound unless @snippet
  end
end
