class ImagesController < ApplicationController

  before_filter :find_image

  def destroy
    @image.destroy
    redirect_to edit_project_measurement_path(params[:project_id],params[:measurement_id])
  end

private

  def find_image
    @image = Image.find(params[:id])
  end
end
