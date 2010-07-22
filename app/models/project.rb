class Project < ActiveRecord::Base

  include AASM
  
  belongs_to :shop
  belongs_to :client

  has_many :estimates, :dependent => :destroy
  has_many :measurements, :dependent => :destroy
  has_many :elements, :dependent => :destroy

  before_save :check_automatic_transitions

  validates_presence_of :address
  validates_presence_of :code

  validate :user_must_belong_to_project_shop
  validate :accepted_estimate_must_have_measurements

  aasm_state :estimated
  aasm_state :waiting
  aasm_state :measured
  aasm_state :accepted
  aasm_state :ordered
  aasm_state :received
  aasm_state :installing
  aasm_state :completed

  aasm_event :back_to_estimated do
    transitions :from => :measured, :to => :estimated, :guard => !:has_measurements?
    transitions :from => :accepted, :to => :estimated, :guard => !:has_measurements?
  end
  
  aasm_event :wait do
    transitions :from => :estimated, :to => :waiting
    transitions :from => :measured, :to => :waiting
  end

  aasm_event :measure do
    transitions :from => :estimated, :to => :measured, :guard => :has_measurements?
    transitions :from => :waiting, :to => :measured, :guard => :has_measurements?
    transitions :from => :accepted, :to => :measured, :guard => :has_measurements?
  end

  aasm_event :accept do
    transitions :from => :measured, :to => :accepted, :guard => :estimate
    transitions :from => :estimated, :to => :accepted, :guard => :has_measurements? and :estimate
  end

  aasm_event :order do
    transitions :from => :accepted, :to => :ordered
  end

  aasm_event :receive do
    transitions :from => :ordered, :to => :received
  end

  aasm_event :install do
    transitions :from => :received, :to => :installing
  end

  aasm_event :complete do
    transitions :from => :installing, :to => :completed
  end

  aasm_initial_state :estimated
  aasm_column :state

  def estimate
    self.estimates.select{|e| e.id == self.accepted_estimate_id}.first rescue nil
  end

  def cost_price
    self.elements.inject(0) { |sum, obj | sum + (obj.units * obj.cost_price) + obj.assembly_price} unless self.elements.nil?
  end

  def has_measurements?
    !self.measurements.empty? rescue false
  end

  def has_accepted_estimate_and_related_measurement?
    self.estimate and !self.estimate.measurements.empty? rescue false
  end


private
  def check_automatic_transitions
    self.accept! if [:measured, :waiting, :estimated].include? self.aasm_current_state and self.estimate and has_measurements?
    self.measure! if [:estimated, :waiting].include? self.aasm_current_state and has_measurements?
    self.measure! if [:accepted].include? self.aasm_current_state and !self.estimate
    self.back_to_estimated! if [:measured, :accepted].include? self.aasm_current_state and !has_measurements?
  end

  def user_must_belong_to_project_shop
    errors.add(:shop_id, errors.generate_message(:shop_id, :same_as_user)) unless (User.current_user.admin? || User.current_user.shop_id == self.shop_id)
  end

  def accepted_estimate_must_have_measurements
    errors.add(:accepted_estimate_id, errors.generate_message(:accepted_estimate_id, :must_have_measurements)) if (self.estimate.measurements.empty? rescue false)
  end
end
