class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :username, presence: true, uniqueness: true
  auth_key :username
end
