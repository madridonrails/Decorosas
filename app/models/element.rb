class Element < ActiveRecord::Base

  belongs_to :project

  validates_presence_of :description
  validates_presence_of :cost_price
  validates_presence_of :units
  validates_presence_of :project_id
  validates_presence_of :assembly_price

  validates_numericality_of :units, :only_integer => true, :unless => Proc.new{|element| element.units.blank?}
  validates_numericality_of :cost_price, :unless => Proc.new{|element| element.cost_price.blank?}
  validates_numericality_of :assembly_price, :unless => Proc.new{|element| element.assembly_price.blank?}

  def total_cost_price
    self.cost_price * self.units
  end

  def final_price
    self.total_cost_price + self.assembly_price
  end
  
end
