class LeaveMailer < ApplicationMailer
  default from: 'anithasai@gmail.com'

  def leave_request_email(supervisor, employee, leave_request)
    @supervisor = supervisor
    @employee = employeerails 
    @leave_request = leave_request

    mail(to: "anithasaisadhanala01@gmail.com", subject: 'New Leave Request for Approval')
  end
end
