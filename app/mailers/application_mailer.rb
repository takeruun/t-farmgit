class ApplicationMailer < ActionMailer::Base
  #default from: 'from@example.com'
  default from: '管理人 <info@t-farm.tk>'
  layout 'mailer'
end
