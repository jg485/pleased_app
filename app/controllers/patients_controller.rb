class PatientsController < ApplicationController
before_filter :authenticate_user!
before_filter :admin_filter, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @patient = Patient.new
    @group = Group.all
  end

  def index
    @patients = Patient.all
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:success] = "Patient created successfully"
      redirect_to '/patients'
    else
      render 'new'
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def show
    @patient = Patient.find(params[:id])
    @comment = Comment.new
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:success] = "Patient record updated successfully"
      redirect_to @patient
    else
      render 'edit'
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "Patient Record deleted."
    redirect_to patients_path
  end

private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :phone, :group_id)
  end

end



