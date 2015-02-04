class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper

  protect_from_forgery with: :exception

  def generic_create type_class, father_class, father_id, type_params
    father = father.class.find(params[:father_id])
    type = father
  end

  def prepare_create type_class, type_params, pluralized_type
    type = pluralized_type.build(type_params)
    return type
  end

  def create_save type
    if type.save
      redirect_to type
    else
      flash[:notice] = "invalid #{type.class}. :("
      render 'new'
    end
  end
end
