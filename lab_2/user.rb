require 'pony'

module MyApplacationSelin
  class User
    def initialize(email, password)
      @email, @password, = email, password
    end
    attr_accessor :email, :password

    def send_message(to, subject, body, attachment)
      Pony.mail({
        :to => to,
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => email,
          :password             => password,
          :authentication       => :plain,
          :domain               => "localhost.localdomain"
        },
        :subject => subject,
        :body => body,
        :attachments => {attachment[:title] => File.read(attachment[:file_path], :binmode => true)}
      })
    end
  end
end