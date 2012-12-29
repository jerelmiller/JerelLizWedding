class Admin::ImagesController < Admin::AdminController

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    @image.user = current_user

    if @image.save
      flash[:success] = "The image has been successfully uploaded"
      redirect_to admin_root_path
    else
      flash[:error] = @image.errors.full_messages.join('<br>')
      redirect_to new_admin_image_path
    end
  end
end