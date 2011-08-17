require 'spec_helper'

describe Newsletter do

  def reset_newsletter(options = {})
    @valid_attributes = {
      :id => 1,
      :volume => "RSpec is great for testing too"
    }

    @newsletter.destroy! if @newsletter
    @newsletter = Newsletter.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_newsletter
  end

  context "validations" do

    it "rejects empty volume" do
      Newsletter.new(@valid_attributes.merge(:volume => "")).should_not be_valid
    end

    it "rejects non unique volume" do
      # as one gets created before each spec by reset_newsletter
      Newsletter.new(@valid_attributes).should_not be_valid
    end

  end

  it "has month and year" do
    news = Newsletter.new(@valid_attributes.merge({:publish_on => "20110817T00:00"}))
    news.year.should == 2011
    news.month.should == "August"
  end

  it "has current newsletter" do
    Newsletter.create!(@valid_attributes.merge(:publish_on => Time.zone.now + 1.days, :volume => "zero"))
    latest =Newsletter.create!(@valid_attributes.merge(:publish_on => Time.zone.now - 3.hours, :volume => "one"))
    Newsletter.create!(@valid_attributes.merge(:publish_on => Time.zone.now - 1.month, :volume => "two"))
    Newsletter.create!(@valid_attributes.merge(:publish_on => Time.zone.now - 1.year, :volume => "three"))

    puts Newsletter.find(:all).inspect
    Newsletter.published.count.should == 3
    Newsletter.current.id.should == latest.id
  end
end
