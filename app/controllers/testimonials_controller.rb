class TestimonialsController < ApplicationController
  before_action :authenticate_patient!, only: [ :new, :create, :update, :destroy ]
  before_action :set_psychologist, only: [ :new, :create ]
  before_action :set_testimonial, only: [ :update, :destroy]

  def index
    @testimonials = Testimonial.all
  end

  def new
    @testimonial = @psychologist.testimonials.new  # Initialize a new testimonial for the psychologist
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    if @testimonial.save
      redirect_to @testimonial, notice:"Depoimento criado com sucesso."
    else
      render :new
    end
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to @testimonial, notice: "Depoimento atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to testimonials_url, notice: "Depoimento excluído com sucesso."
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def set_psychologist
    # Make sure psychologist_id is being passed correctly in the URL params
    @psychologist = Psychologist.find_by(id: params[:psychologist_id])
    if @psychologist.nil?
      redirect_to root_path, alert: "Psychologist not found."
    end
  end

  def testimonial_params
    params.require(:testimonial).permit(:content, :patient_id, :psychologist_id)
  end
end
