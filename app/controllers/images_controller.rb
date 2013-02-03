class ImagesController < ApplicationController
  def url
    image = Image.find(params[:id])
    render json: { image_url: image.image.url(params[:size].try(:to_sym)) }
  end
end