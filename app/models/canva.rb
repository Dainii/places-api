# frozen_string_literal: true

class Canva < ApplicationRecord
  kredis_hash :boxes_color

  ALLOWED_COLORS = ['#FFFFFF', '#000000'].freeze

  def initialize_data
    (0..length - 1).each do |x|
      (0..height - 1).each do |y|
        boxes_color.update("#{x}:#{y}" => '#FFFFFF')
      end
    end
  end

  def as_json(options = {})
    super(options).except('token', 'length', 'height').merge({ boxes_color: boxes_color.to_h })
  end

  def update_box_data(params)
    return false unless valid_box_data?(params)

    boxes_color.update("#{params[:x]}:#{params[:y]}" => params[:color])
  end

  def broadcast_box_update(params)
    ActionCable.server.broadcast(
      "canva_#{id}",
      {
        boxes: [
          { x: params[:x], y: params[:y], color: params[:color] }
        ]
      }
    )
  end

  private

  def valid_box_data?(params)
    return false unless valid_color?(params[:color])
    return false unless valid_coordonate?(params[:x].to_i, params[:y].to_i)

    true
  end

  def valid_color?(color)
    ALLOWED_COLORS.include?(color)
  end

  def valid_coordonate?(x, y)
    return false if x.negative? || x >= length
    return false if y.negative? || y >= height

    true
  end
end
