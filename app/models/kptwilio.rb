class Kptwilio

   attr_accessor :to_number, :from_number, :body

   def initialize(to_number, from_number, body)
      @to_number = to_number
      @from_number = from_number
      @body = body
   end

  def send
  	
  	# Get your Account Sid and Auth Token from twilio.com/user/account 
    account_sid = 'ACe141f2c62c8497956a83d0ffa61eca27'
    auth_token = '7afb7431bb3d199bf07605c5c72271dc'
    @client = Twilio::REST::Client.new account_sid, auth_token

    message = @client.account.sms.messages.create(:body => body,
          :to => to_number,     # Replace with your phone number
          :from => from_number)   # Replace with your Twilio number
        puts message.sid

  end

end