class TestimonialsController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :destroy ]
  before_action :set_testimonial, only: [ :edit, :update, :destroy ]

  def index
    @testimonials = Testimonial.all
  end

  def edit
    authorize @testimonial
  end

  def update
    authorize @testimonial
    if @testimonial.update(testimonial_params)
      redirect_to root_path, notice: "Testimonial updated successfully."
    else
      render :edit
    end
  end

  def destroy
    authorize @testimonial
    @testimonial.destroy
    redirect_to root_path, notice: "Testimonial deleted successfully."
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:content)
  end
end
