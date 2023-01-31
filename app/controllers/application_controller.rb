class ApplicationController < ActionController::Base
  # This code will provide error responses when exceptions are raised in the other controllers. It's in this file because the application controller is the top-level controller and so these rescue responses will be accessible in every controller as a result.

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def render_not_found_response(exception)
  render json: { error: "#{exception.model} not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
  render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
