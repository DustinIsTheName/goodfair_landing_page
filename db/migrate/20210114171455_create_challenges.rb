class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|

      t.string :email
      t.text :friend_email_hashs

      t.timestamps
    end
  end
end
