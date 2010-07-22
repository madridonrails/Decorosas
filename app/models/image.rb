class Image < ActiveRecord::Base
  belongs_to :measurements
  has_attached_file :data, :styles => {:medium => '300x300', :thumb => '100x100'}
end
