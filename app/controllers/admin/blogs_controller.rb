class Admin::BlogsController < Admin::AdminController
  
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(params[:blog])

    if @blog.save
      flash[:success] = "Successfully created blog"
      redirect_to admin_blogs_path
    else
      flash[:error] = @blog.errors.full_messages
      render :new
    end

  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update_attributes(params[:blog])
      flash[:success]  = "Successfully updated blog"
      redirect_to admin_blog_path(@blog)
    else
      flash[:error] = @blog.errors.full_messages.join('<br/>')
      render :edit
    end
  end

end