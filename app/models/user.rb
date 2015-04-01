class User < ActiveRecord::Base
	has_many :roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
  	"#{email} (#{admin? ? "Admin" : "User"})"
  end

  def role_on(xfile)
  	roles.find_by(xfile_id: xfile).try(:name)
  end
end
