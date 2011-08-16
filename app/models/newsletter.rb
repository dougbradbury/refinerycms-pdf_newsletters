class Newsletter < ActiveRecord::Base

  acts_as_indexed :fields => [:volume, :issue]

  validates :volume, :presence => true, :uniqueness => true
  
  belongs_to :pdf, :class_name => 'Resource'
end
