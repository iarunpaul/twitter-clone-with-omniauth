json.extract! tweeet, :id, :tweeet, :created_at, :updated_at
json.url tweeet_url(tweeet, format: :json) if current_user == tweeet.user
json.author do |json|
  json.author_id tweeet.user.id
  json.author_name tweeet.user.name
  json.author_edit_url edit_user_registration_url
end