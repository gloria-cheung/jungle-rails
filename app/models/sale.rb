class Sale < ApplicationRecord
  
  # AR Scope
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    starts_on < Date.current && ends_on > Date.current
  end

  validates :name, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validates :percent_off, presence: true
end
