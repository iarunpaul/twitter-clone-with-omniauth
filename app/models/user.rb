class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,# :validatable,
          :omniauthable, omniauth_providers: [:twitter]
  has_many :tweeets
  # validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 6, maximum: 50 }
  # validates :name, presence: true, length: { minimum: 4, maximum: 20 }
  validates :email, :password, presence: true, unless: :provider?
  validates :email, uniqueness: { case_sensitive: false }, length: {maximum: 50}, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :password, length: {minimum: 6}, confirmation: :required, unless: :provider?

  def self.find_from_auth_hash(auth_hash)
    byebug
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.nickname
      user.name = auth_hash.info.name
    end
  end

end
