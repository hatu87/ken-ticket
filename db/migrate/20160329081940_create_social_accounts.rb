class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
