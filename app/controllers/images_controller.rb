class ImagesController < ApplicationController

  def show
    image = Image.find(params[:id])
    image_urls = {}
    styles = params[:styles].try(:split, ';').presence || ['original']
    styles.each do |style|
      image_urls[style] = image.image.url(style.to_sym)
    end
    render json: { image_urls: image_urls }
  end
end