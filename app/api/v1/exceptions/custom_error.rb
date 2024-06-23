
class V1::Exceptions::CustomError < StandardError
  def initialize(message = "This is a custom error")
    super(message)
  end
end