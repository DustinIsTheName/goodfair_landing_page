class ChallengeMailer < ApplicationMailer

  def challenge(challenge, hashed_emails = [], friend_emails = [], first_name = "")
    hashed_emails.each_with_index do |hash_email, index|
      send_challenge(challenge, hash_email, friend_emails[index], first_name).deliver
    end
  end

  def send_challenge(challenge, hash, email, name)
    @challenge = challenge
    @hashed_email = hash
    @name = name

    mail(to: email, from: ENV["POSTMARK_FROM_ADDRESS"], subject: "You’ve Been Challenged!")
  end

  def reward(challenge, discount_code)
    @challenge = challenge
    @discount_code = discount_code

    mail(to: challenge.email, from: ENV["POSTMARK_FROM_ADDRESS"], subject: "#NoNewThings: Challenge Accepted!")
  end

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'dustin@wittycreative.com',
      from: 'dustin@wittycreative.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end

end