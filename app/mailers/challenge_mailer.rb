class ChallengeMailer < ApplicationMailer

  def challenge(emails = [])
    # @challenge = challenge

    for email in emails
      send_challenge(email).deliver
    end
  end

  def reward(challenge)
    @challenge = challenge
  end

  def send_challenge(email)
    mail(to: email, from: "dustin@wittycreative.com", subject: "#NoNewThings challenge")
  end

end