class LeaveMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def leave_request_email(supervisor, employee, leave_request)
    @supervisor = supervisor
    @employee = employee
    @leave_request = leave_request

    mail(to: "anithasaisadhanala01@gmail.com", subject: 'New Leave Request for Approval')
  end
end
