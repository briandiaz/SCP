class User < ActiveRecord::Base
  belongs_to :person
  belongs_to :role
  
  def self.from_omniauth(auth,person_id)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth,person_id)
  end

  def self.create_with_omniauth(auth,person_id)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.person_id = person_id
      user.role_id = 4 # Disabled
      NotificationsMailer.notifications(user).deliver
    end
  end
  
end
