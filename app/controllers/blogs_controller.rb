class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all

    if params[:q].present?
      @blogs = Blog.where("title LIKE ? OR body LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    if params[:category].present?
      @category = Category.find_by(name: params[:category])
      @blogs = @category? @category.blogs : []
    end
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    #@blog = Blog.new
    @blog = current_user.blogs.build
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    #@blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        @blog.category_ids = params[:blog][:category_ids]
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :body, category_ids: [])
    end
  
    private

    def authorize_user!
      unless current_user == @blog.user
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
end
