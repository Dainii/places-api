# frozen_string_literal: true

class CanvasController < ApplicationController
  before_action :set_canva, only: %i[show update destroy update_canva_boxes]

  # GET /canvas
  def index
    @canvas = Canva.all

    render json: @canvas
  end

  # GET /canvas/1
  def show
    render json: @canva
  end

  # POST /canvas
  def create
    @canva = Canva.new(canva_params)

    if @canva.save
      @canva.initialize_data
      render json: @canva, status: :created, location: @canva
    else
      render json: @canva.errors, status: :unprocessable_entity
    end
  end

  # POST /canvas/1
  def update_canva_boxes
    if @canva.update_box_data(box_params)
      @canva.broadcast_box_update(box_params)
      render json: 'update: ok', status: :created
    else
      render json: @canva.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /canvas/1
  def update
    if @canva.update(canva_params)
      render json: @canva
    else
      render json: @canva.errors, status: :unprocessable_entity
    end
  end

  # DELETE /canvas/1
  def destroy
    @canva.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_canva
    @canva = Canva.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def canva_params
    params.permit(:name, :height, :length)
  end

  # Only allow a list of trusted parameters through.
  def box_params
    params.permit(:id, :x, :y, :color)
  end
end
