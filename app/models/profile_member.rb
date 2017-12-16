class ProfileMember < ActiveRecord::Base
  belongs_to :member

  def full_name
    "#{first_name} #{second_name}"
  end
end
