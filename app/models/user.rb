class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders
  has_many :events
  has_many :social_accounts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    account = SocialAccount.find_by_uid(auth[:uid])
    # binding.pry
    if account.nil?
      existed_user = User.find_by_email(email)
      # binding.pry
      if existed_user.nil?
        # cannot find old email. Your account is not existed
        # create new user & account
        # binding.pry
        existed_user = User.create(name: auth[:info][:name], email: email,
          password: '12345678', password_confirmation: '12345678')
      end
      # binding.pry
      existed_user.social_accounts.create(uid: auth[:uid], provider: auth[:provider])

      # existed_user && existed_user.accounts.create(uid: auth[:uid], provider: auth[:provider]).user
    else
      # facebook account is existed
      account.user
    end
  end
end
