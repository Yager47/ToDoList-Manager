class User < ActiveRecord::Base
  devise :token_authenticatable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :timeoutable

  has_many :task_lists, foreign_key: :owner_id

  # attr_accessible :provider, :uid

  after_create :create_task_list

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end

  def create_task_list
    task_lists.create!(name: "My first list")
  end

  def first_list
    task_lists.first
  end

  def self.find_for_facebook_auth(access_token)
    if user = User.where(email: access_token.extra.raw_info.email)
      user
    else 
      User.create!(
        email: access_token.extra.raw_info.email, 
        password: Devise.friendly_token[0,20]
      ) 
    end
  end

  def self.from_omniauth(auth)
    # where(auth.slice(:provider, :uid)).first_or_create do |user|
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|  
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
end
