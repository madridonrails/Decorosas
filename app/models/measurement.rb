class Measurement < ActiveRecord::Base

  belongs_to :project

  has_and_belongs_to_many :estimates

  has_many :images

  validates_presence_of :project_id
  validates_presence_of :description

  def image_attributes=(image_attributes)
    image_attributes.each do |attributes|
      images.build(attributes)
    end
  end

end
