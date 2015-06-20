class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :dj

  has_many :attendances
  has_many :events, through: :attendances

  has_many :talent_fors
  has_many :shows, through: :talent_fors


  #----------- Class Methods -----------

end
