class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recommendations
  after_create :create_profile!

  # Modified version of FutureTech Corp's create_profile function https://github.com/cse-3901-sharkey/FutureTechCorp/blob/0e36df77201610c1bb973a4d2bab11b3e1d653bc/lab-4/app/models/user.rb
  def create_profile!
    profile = User.find_by(id: id)
    # assign the name dot number to the user by getting it from the email
    profile.name_dot_number = profile.email.partition("@").first

    # url to get the profile info from osu directory
    base_url = 'http://directory.osu.edu/fpjson.php'
    
    response = RestClient.get(base_url, { params: {
        name_n: profile.name_dot_number 
    }})

    result = JSON.parse(response)
    result = result[0]

    if result != nil
      # If the user found has a major assign them as a ta
      if result["majors"].length > 0
        profile.user_type = "TA"
      # Else assign them as a staff
      else
        profile.user_type = "Staff"
      end
      profile.save
    # If user not found, still assign them as a ta
    else
      profile.user_type = "TA"
      profile.save
    end
  end
end
