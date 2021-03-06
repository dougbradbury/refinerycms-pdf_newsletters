class PdfNewsletter < ActiveRecord::Base

  acts_as_indexed :fields => [:volume, :issue]

  validates :volume, :presence => true
  validates :issue, :presence => true
  validates :pdf, :presence => true

  belongs_to :pdf, :class_name => 'Resource'

  def title
    "#{month} Newsletter"
  end

  def month
    self.publish_on.strftime("%B")
  end

  def year
    self.publish_on.year
  end
  scope :published, lambda {
    where("pdf_newsletters.publish_on IS NOT NULL AND pdf_newsletters.publish_on <= ?", Time.zone.now)
  }

  scope :recent, published.order("pdf_newsletters.publish_on DESC")

  def self.current
   self.recent.first
  end

  def self.whats_new?
    true
  end
end
