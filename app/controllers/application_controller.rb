class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SessionsHelper

  protect_from_forgery with: :exception

  def prepare_create type_class, type_params, pluralized_type
    type = pluralized_type.build(type_params)
    if type.save
      redirect_to type
    else
      render 'new'
    end
  end
end
