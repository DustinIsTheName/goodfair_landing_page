class CreateChallenges < ActiveRecord::Migration[6.0]

  before_action :set_headers

  def change
    create_table :challenges do |t|

      t.string :email
      t.string :friend_1_email_hash
      t.string :friend_2_email_hash
      t.boolean :friend_1_activated
      t.boolean :friend_2_activated

      t.timestamps
    end
  end

  private

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
    end
end
