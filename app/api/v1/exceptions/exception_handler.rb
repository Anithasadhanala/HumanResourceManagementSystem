

module V1::Exceptions
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ error: { status: 422, message: e.message } }, 422)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: { status: 404, message: e.message } }, 404)
      end


      rescue_from RuntimeError do |e|
        error!({ error: { status: 422, message:  e.message} }, 422)
      end


      # ------------------ tried using customErrors (TODO)------------------------
      # rescue_from CustomError do |e|
      #   error_response(422000, e.message)
      # end
      # rescue_from JWT::DecodeError do |e|
      #   error!({ error: { status: 401, message: 'Invalid token' } }, 401)
      # end
      # helpers do
      #   def error_response(status, message)
      #     error!({ error: { status: status, message: message } }, status)
      #   end
      # end
    end
  end
end
