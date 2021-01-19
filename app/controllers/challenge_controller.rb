class ChallengeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:submit_pledge]
  before_action :set_headers

  def submit_pledge
    puts "test"
 
    challenge = Challenge.find_by_email params["email"]
    email = params["email_address"]
    friend_1_email = params["challenge_friend_1_email"]
    friend_2_email = params["challenge_friend_2_email"]

    unless challenge
      unless email.blank? and (friend_1_email.blank? or friend_2_email.blank?)

        challenge = Challenge.new
        challenge.email = email
        challenge.friend_1_email_hash = Digest::MD5.hexdigest(friend_1_email)
        challenge.friend_2_email_hash = Digest::MD5.hexdigest(friend_2_email)

        if challenge.save
          puts Colorize.green("challenge saved for #{email}")

          ChallengeMailer.challenge(challenge, [friend_1_email, friend_2_email]).deliver
        end

      end
    end

    render json: params
  end

  def redeem
    render json: params
  end

  private

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
    end
end
