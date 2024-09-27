class PatientsController < ApplicationController
  before_action :set_patient, only: [ :show, :new, :create, :edit, :update, :destroy ]
  before_action :authenticate_patient!, only: [ :profile, :new, :edit, :update, :destroy ]

  def profile
    @patient = current_patient
    @appointments = @patient.appointments || [] # Garante que @appointments nunca será nil
    @appointment = Appointment.where(status: "available").first # Consulta disponível
  end

  def show
    @appointments = @patient.appointments
  end

  def new
    @appointment = Patient.find(params[:id])
    @appointment = Appointment.new
  end

  def appointments
    @appointments = current_patient.appointments
  end

  def edit
    # Editing patient profile
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient profile was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to root_path, notice: "Patient profile was successfully deleted."
  end

  def sign_out
    # Logic for sign out, if needed
  end

  def create
  end

  private

  def set_patient
    if params[:id].present? && params[:id] != "sign_out"
      @patient = Patient.find(params[:id])
    else
      @patient = current_patient
    end

    # Redireciona se o paciente não for encontrado
    unless @patient
      redirect_to root_path, alert: "Patient not found."
    end
  end


  def patient_params
    params.require(:patient).permit(:full_name, :address, :date_of_birth, :email, :photo, :phone_number, :other_attributes)
  end
end
