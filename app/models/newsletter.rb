class Newsletter < ActiveRecord::Base

  acts_as_indexed :fields => [:volume, :issue]

  validates :volume, :presence => true, :uniqueness => true

  belongs_to :pdf, :class_name => 'Resource'

  def month
    self.publish_on.strftime("%B")
  end

  def year
    self.publish_on.year
  end
  scope :published, lambda { 
    where("newsletters.publish_on IS NOT NULL AND newsletters.publish_on <= ?", Time.zone.now)
  }

  scope :recent, published.order("newsletters.publish_on DESC")

  def self.current
   self.recent.first
  end
end
