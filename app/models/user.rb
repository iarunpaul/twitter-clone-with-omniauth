class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,# :validatable,
          :omniauthable, omniauth_providers: [:twitter]
  has_many :tweeets
  # validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 6, maximum: 50 }
  # validates :name, presence: true, length: { minimum: 4, maximum: 20 }
  validates :email, presence: true#, unless: :provider?
  validates :password, presence: true, length: {minimum: 6}, confirmation: :required, on: :create, unless: :provider?
  validates :email, uniqueness: { case_sensitive: false }, length: {maximum: 50}, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :username, uniqueness: { case_sensitive: false }, length: {maximum: 15}, unless: :provider?
  validates :password, length: {minimum: 6}, confirmation: :required, allow_blank: true, on: :update#, unless: :provider?

def password_required?
  provider.blank? || !password.nil? || !password_confirmation.nil?
end


  def self.find_from_auth_hash(auth_hash)
    # byebug
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.nickname
      user.name = auth_hash.info.name
      user.email = auth_hash.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
