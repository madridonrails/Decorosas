class Client < ActiveRecord::Base

  has_many :projects

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :phone
end
