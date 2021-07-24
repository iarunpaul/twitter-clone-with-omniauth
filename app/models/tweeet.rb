class Tweeet < ApplicationRecord
belongs_to :user

  def as_json(options={})
    super({except: [:created_at, :updated_at], include: {user: {only: [:name, :email]}}}.merge{options})
  end
end
