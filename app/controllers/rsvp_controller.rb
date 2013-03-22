class RsvpController < ApplicationController
  def create
    @rsvp = Rsvp.new params[:rsvp]
    ActiveRecord::Base.transaction do
      if @rsvp.save
        RsvpMailer.notify_new_rsvp(@rsvp).deliver
        render json: params[:rsvp].slice(:name, :attending)
      else
        render status: :unprocessable_entity, json: { errors: @rsvp.errors.full_messages }
      end
    end
  end
end