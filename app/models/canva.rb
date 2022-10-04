# frozen_string_literal: true

class Canva < ApplicationRecord
  kredis_hash :color

  ALLOWED_COLORS = ['#FFFFFF', '#000000'].freeze

  def initialize_data
    (0..length - 1).each do |x|
      (0..height - 1).each do |y|
        color.update("#{x}:#{y}" => '#FFFFFF')
      end
    end
  end

  def valid_box?(params)
    return false unless valid_color?(params[:color])
    return false unless valid_coordonate?(params[:x], params[:y])

    true
  end

  def as_json(options = {})
    super(options).except(:token, :lenght, :height).merge({ color: color.to_h })
  end

  def update_data(params)
    color.update("#{params[:x]}:#{params[:y]}" => params[:color])
  end

  private

  def valid_color?(color)
    ALLOWED_COLORS.include?(color)
  end

  def valid_coordonate?(x, y)
    return false if x.negative? || x >= length
    return false if y.negative? || y >= height
  end
end
