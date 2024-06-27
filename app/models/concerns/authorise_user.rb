# app/models/concerns/user_common.rb
module AuthoriseUser
  extend ActiveSupport::Concern

  def authorise_user(user_id)
    if  !Current.user.role == "admin" || Current.user.id == user_id
      raise RuntimeError, {message: "Not Authorised to access this content!!!"}
    end
  end


  def authorise_employee(employee_id)
    if  !Current.user.id == employee_id
      raise RuntimeError, {message: "Not Authorised to access this content!!!"}
    end
  end


end
