class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :no_record_found

    def index
        render json: Spice.all, status: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :ok
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def no_record_found
        render json: { error: "Spice not found" }, status: :not_found
    end
end
