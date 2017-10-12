class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  def new; end

  def index
    @posts = Post.all
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
