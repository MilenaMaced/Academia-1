class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def authorize
    unless logged_in?
      redirect_to root_url
    end
  end

  def authorize_admin_professor
    if logged_in?
      unless current_user.admin? or current_user.professor?
        redirect_to current_user
      end
    else
      redirect_to root_url
    end
  end

  def correct_user_treino
    if logged_in?
      @treino = Treino.find(params[:id])
      unless current_user.admin? or current_user.professor? or @treino.aluno_id == current_user.id
        redirect_to @treino
      end
    else
      redirect_to root_url
    end
  end
  def correct_user_anamnese
    if logged_in?
      @anamnese = Anamnese.find(params[:id])
      unless current_user.admin? or current_user.professor? or @anamnese.usuario_id == current_user.id
        redirect_to  @anamnese
      end
    else
      redirect_to root_url
    end
  end

  def correct_user?
    if logged_in?
      @usuario = Usuario.find(params[:id])
      unless current_user == @usuario or current_user.admin?
        redirect_to @usuario
      end
    else
      redirect_to root_url
    end
  end
end
