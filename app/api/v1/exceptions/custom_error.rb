module V1
  module Exceptions
    class CustomError < StandardError
      def initialize(message = nil)
        super( "A custom error occurred---------------")
      end
    end
  end
end
