class RsvpController < ApplicationController
  def create
    @rsvp = Rsvp.new params[:rsvp]
    if @rsvp.save
      render json: params[:rsvp].slice(:name, :attending)
    else
      render status: :unprocessable_entity, json: { errors: @rsvp.errors.full_messages }
    end
  end
end