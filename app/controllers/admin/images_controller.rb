class Admin::ImagesController < Admin::AdminController

  def index
    @images = Image.order('created_at desc')
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

  def update
    @image = Image.find(params[:id])
    @image.update_attributes(params[:image])

    respond_to do |format|
      format.html { redirect_to admin_images_path }
      format.js { render json: @image, status: :accepted }
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.image.destroy
    @image.destroy

    respond_to do |format|
      format.html { redirect_to admin_images_path }
      format.js { render json: '', status: :ok }
    end
  end
end