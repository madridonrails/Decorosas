class Estimate < ActiveRecord::Base

  belongs_to :project

  has_and_belongs_to_many :measurements

  validates_presence_of :project_id
  validates_presence_of :price
  validates_numericality_of :price
end
