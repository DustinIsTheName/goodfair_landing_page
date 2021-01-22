class ChallengeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:submit_pledge, :redeem, :get_signup_count]
  before_action :set_headers

  def submit_pledge 

    properties = {
      '$first_name': params["first_name"],
      '$last_name': params["last_name"]
    }

    if params["pledge_category_clothing"]
      clothing_subcategory = []
      clothing_subcategory << "Fast Fashion" if params["pledge_subcategory_fast_fashion"]
      clothing_subcategory << "Denim" if params["pledge_subcategory_denim"]
      clothing_subcategory << "Occasionwear" if params["pledge_subcategory_occasionwear_dresses_suits"]
      clothing_subcategory << "Tops" if params["pledge_subcategory_tops"]
      clothing_subcategory << "Bottoms" if params["pledge_subcategory_bottoms"]
      clothing_subcategory << "Outerwear" if params["pledge_subcategory_outerwear"]
      clothing_subcategory << "T-shirts" if params["pledge_subcategory_t_shirts"]
      clothing_subcategory << "Other: #{params["pledge_subcategory_clothing_other_elaboration"]}" if params["pledge_subcategory_clothing_other"]
      properties["clothing"] = clothing_subcategory
    end

    if params["pledge_category_shoes_accessories"]
      shoes_accessories_subcategory = []
      shoes_accessories_subcategory << "Shoes" if params["pledge_subcategory_shoes"]
      shoes_accessories_subcategory << "Jewelry" if params["pledge_subcategory_jewelry"]
      shoes_accessories_subcategory << "Handbags" if params["pledge_subcategory_handbags"]
      shoes_accessories_subcategory << "Bags" if params["pledge_subcategory_bags_backpacks_duffle_bags"]
      shoes_accessories_subcategory << "Sunglasses" if params["pledge_subcategory_sunglasses"]
      shoes_accessories_subcategory << "Hair Accessories" if params["pledge_subcategory_hair_accessories"]
      shoes_accessories_subcategory << "Cold Weather Accessories" if params["pledge_subcategory_cold_weather_accessories_scarves_gloves"]
      shoes_accessories_subcategory << "Other: #{params["pledge_subcategory_shoes_accessories_other_elaboration"]}" if params["pledge_subcategory_shoes_accessories_other"]
      properties["shoes_accessories"] = shoes_accessories_subcategory
    end

    if params["pledge_category_home_goods"]
      home_goods_subcategory = []
      home_goods_subcategory << "Furniture" if params["pledge_subcategory_furniture"]
      home_goods_subcategory << "Home" if params["pledge_subcategory_home_textiles_blankets_pillows_towels"]
      home_goods_subcategory << "Art" if params["pledge_subcategory_art"]
      home_goods_subcategory << "Rugs" if params["pledge_subcategory_rugs"]
      home_goods_subcategory << "Decor" if params["pledge_subcategory_decor"]
      home_goods_subcategory << "Kitchenware" if params["pledge_subcategory_kitchenware"]
      home_goods_subcategory << "Holiday Seasonal Decor" if params["pledge_subcategory_holiday_seasonal_decor"]
      home_goods_subcategory << "Other: #{params["pledge_subcategory_home_goods_other_elaboration"]}" if params["pledge_subcategory_home_goods_other"]
      properties["home_goods"] = home_goods_subcategory
    end

    if params["pledge_category_electronics"]
      electronics_subcategory = []
      electronics_subcategory << "Cell Phone" if params["pledge_subcategory_cell_phone"]
      electronics_subcategory << "Computer" if params["pledge_subcategory_computer"]
      electronics_subcategory << "Web Cam" if params["pledge_subcategory_web_cam"]
      electronics_subcategory << "Appliances" if params["pledge_subcategory_appliances"]
      electronics_subcategory << "Other: #{params["pledge_subcategory_electronics_other_elaboration"]}" if params["pledge_subcategory_electronics_other"]
      properties["electronics"] = electronics_subcategory
    end

    if params["pledge_category_single_uses_plastic_products"]
      single_uses_plastic_subcategory = []
      single_uses_plastic_subcategory << "Bags" if params["pledge_subcategory_bags"]
      single_uses_plastic_subcategory << "Bottles" if params["pledge_subcategory_bottles"]
      single_uses_plastic_subcategory << "Toothbrushes" if params["pledge_subcategory_toothbrushes"]
      single_uses_plastic_subcategory << "Straws" if params["pledge_subcategory_straws"]
      single_uses_plastic_subcategory << "Other: #{params["pledge_subcategory_single_use_plastic_other_elaboration"]}" if params["pledge_subcategory_single_use_plastic_other"]
      properties["single_use_plastic"] = single_uses_plastic_subcategory
    end

    if params["pledge_category_single_uses_paper_products"]
      single_uses_paper_subcategory = []
      single_uses_paper_subcategory << "Paper Towels/Napkins" if params["pledge_subcategory_paper_towels_napkins"]
      single_uses_paper_subcategory << "Paper Plates" if params["pledge_subcategory_paper_plates"]
      single_uses_paper_subcategory << "Printer Paper" if params["pledge_subcategory_printer_paper"]
      single_uses_paper_subcategory << "Other: #{params["pledge_subcategory_single_use_paper_other_elaboration"]}" if params["pledge_subcategory_single_use_paper_other"]
      properties["single_use_paper"] = single_uses_paper_subcategory
    end

    if params["pledge_category_gift_secondhand"]
      gift_secondhand_subcategory = []
      gift_secondhand_subcategory << "Birthdays" if params["pledge_subcategory_birthdays"]
      gift_secondhand_subcategory << "Mother's/Father's Day" if params["pledge_subcategory_mother_s_father_s_day"]
      gift_secondhand_subcategory << "Holidays" if params["pledge_subcategory_holidays"]
      gift_secondhand_subcategory << "Wedding Gifts" if params["pledge_subcategory_wedding_gifts"]
      gift_secondhand_subcategory << "Other: #{params["pledge_subcategory_gift_other_elaboration"]}" if params["pledge_subcategory_gift_other"]
      properties["gift_secondhand"] = gift_secondhand_subcategory
    end

    if params["pledge_category_transportation"]
      transportation_subcategory = []
      transportation_subcategory << "Carpool" if params["pledge_subcategory_carpool"]
      transportation_subcategory << "Bicycle" if params["pledge_subcategory_bicycle"]
      transportation_subcategory << "Walk" if params["pledge_subcategory_walk"]
      transportation_subcategory << "Bus Subway" if params["pledge_subcategory_public_transportation_bus_subway"]

      transportation_subcategory << "Other: #{params["pledge_subcategory_transportation_other_elaboration"]}" if params["pledge_subcategory_transportation_other"]
      properties["transportation"] = transportation_subcategory
    end

    if params["pledge_category_other"]
      properties["other"] = params["pledge_category_other_elaboration"]
    end

    Klaviyo::Public.identify(
      email: params["email_address"],
      properties: properties
    )

    Klaviyo::Lists.add_subscribers_to_list(
      ENV["KLAVIYO_NONEWTHINGS_LIST_ID"],
      profiles: [
        {
          email: params["email_address"]
        }
      ]
    )

    # challenge = Challenge.find_by_email params["email_address"]
    # first_name = params["first_name"]
    # email = params["email_address"]
    # friend_names = params["challenge_friend_name"].filter{|e| !e.blank?}
    # friend_emails = params["challenge_friend_email"].filter{|e| !e.blank?}

    # unless challenge
    #   unless email.blank? or friend_emails.count == 0

    #     challenge = Challenge.new
    #     challenge.email = email
    #     hashed_array = []
    #     hashed_emails = {}

    #     friend_emails.each do |e|
    #       hashed_emails[Digest::MD5.hexdigest(e)] = false
    #       hashed_array << Digest::MD5.hexdigest(e)
    #     end

    #     challenge.friend_email_hashs = hashed_emails

    #     if challenge.save
    #       puts Colorize.green("challenge saved for #{email}")

    #       ChallengeMailer.challenge(challenge, hashed_array, friend_emails, first_name).deliver
    #     end

    #   end
    # end

    render json: params
  end

  def redeem
    render json: params

    challenge = Challenge.find_by_email params["challenge_email"]

    challenge.friend_email_hashs.select{|h, a| a == true}
    challenge_completed = challenge.friend_email_hashs.select{|h, a| a == true}.count >= 2

    unless challenge.friend_email_hashs[params["hashed_email"]]
      challenge.friend_email_hashs[params["hashed_email"]] = true

      if challenge.save
        puts Colorize.green("activated hash")
        complete_challenge = challenge.friend_email_hashs.select{|h, a| a == true}.count >= 2

        if !challenge_completed and complete_challenge
          code_hash = challenge.friend_email_hashs.select{|h, a| a == true}.map{|h, a| h[0,2]}.join("")[0,4].upcase
          discount_code = "NONEWTHINGS#{code_hash}#{challenge.id}"

          price_rule = ShopifyAPI::PriceRule.new({
            title: discount_code,
            target_type: "line_item",
            target_selection: "all",
            allocation_method: "across",
            value_type: "fixed_amount",
            value: "-10.00",
            customer_selection: "all",
            starts_at: Time.now
          })

          price_rule.save

          shopify_discount_code = ShopifyAPI::DiscountCode.new({
            code: discount_code,
            usage_count: 1,
            price_rule_id: price_rule.id
          })

          shopify_discount_code.save

          ChallengeMailer.reward(challenge, discount_code).deliver
        end
      end
    end
  end

  def get_signup_count
    list = Klaviyo::Lists.get_group_members(ENV['KLAVIYO_NONEWTHINGS_LIST_ID'])
    list_body = JSON.parse(list.body)
    list_count = 0
    list_count += list_body["records"].count

    while list_body["marker"]
      path = "group/#{ENV['KLAVIYO_NONEWTHINGS_LIST_ID']}/members/all"
      params = {
        :marker => list_body["marker"]
      }
      list = Klaviyo::Lists.v2_request('get', path, params)
      list_body = JSON.parse(list.body)
      list_count += list_body["records"].count
      puts list_count
    end

    render json: list_count
  end

  private

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
    end
end


























