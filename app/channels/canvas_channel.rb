# frozen_string_literal: true

class CanvasChannel < ApplicationCable::Channel
  def subscribed
    stream_from "canva_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
