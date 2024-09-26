class AppointmentTypesController < ApplicationController
  def new
    @appointment_type = AppointmentType.new
  end

  def create
    @appointment_type = AppointmentType.new(appointment_type_params)
    if @appointment_type.save
      redirect_to appointments_path, notice: 'Appointment type was successfully created.'
    else
      render :new
    end
  end

  private

  def appointment_type_params
    params.require(:appointment_type).permit(:name, :duration)
  end
end
