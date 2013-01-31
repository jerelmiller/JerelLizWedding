class Admin::BlogsController < Admin::AdminController
  before_filter :set_previous_path, only: [:new, :edit]
  helper_method :previous_path
  
  def index
    @blogs = Blog.order('created_at desc')
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
    @blog = Blog.new(params[:blog].merge(user_id: current_user.id))

    if @blog.save
      flash[:success] = "Successfully created blog"
      redirect_to admin_blogs_path
    else
      flash[:error] = @blog.errors.full_messages.join(', ')
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

  def previous_path
    session[:return_to]
  end

private

  def set_previous_path
    session[:return_to] = request.referer
  end

end