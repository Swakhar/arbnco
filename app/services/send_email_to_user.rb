class SendEmailToUser
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def self.call(email)
    new(email).send_email
  end

  def send_email
    from = SendGrid::Email.new(email: ENV['FROM_EMAIL'])
    to = SendGrid::Email.new(email: email)
    subject = 'Confirmation of Successful Parsing of your file'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Successfully parsed')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
