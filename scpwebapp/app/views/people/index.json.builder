json.array!(@people) do |person|
  json.extract! person, :first_name, :last_name, :sex, :email, :phone, :mobile, :identification_card, :created_at, :updated_at
  json.url person_url(person, format: :json)
end
