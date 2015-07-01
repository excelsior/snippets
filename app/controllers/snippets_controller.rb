class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.order(created_at: :desc).page(params[:page]).per(20)
  end
end
