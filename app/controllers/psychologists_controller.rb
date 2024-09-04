class PsychologistsController < ApplicationController
  before_action :set_psychologist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_psychologist!

  def profile
    @psychologist = current_psychologist
  end

  def show
    # Display psychologist profile
    @appointments = @psychologist.appointments
  end

  def edit
    # Edit psychologist profile
  end

  def update
    if @psychologist.update(psychologist_params)
      redirect_to @psychologist, notice: 'Psychologist profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @psychologist.destroy
    redirect_to root_path, notice: 'Psychologist profile was successfully deleted.'
  end

  private

  def set_psychologist
    @psychologist = current_psychologist
  end

  def psychologist_params
    params.require(:psychologist).permit(:name, :email, :photo, :phone_number, :other_attributes)
  end
end
