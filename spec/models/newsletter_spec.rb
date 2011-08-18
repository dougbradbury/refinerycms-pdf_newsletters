require 'spec_helper'

describe Newsletter do

  def reset_newsletter(options = {})
    @valid_attributes = {
      :id => 1,
      :volume => "Test Volume",
      :issue => "Test Issue",
      :pdf => mock_model(Resource)
    }

    @newsletter.destroy! if @newsletter
    @newsletter = Newsletter.create!(@valid_attributes.update(options))
  end

  def create_newsletter(publish_on)
    Newsletter.create!(@valid_attributes.merge(:publish_on => publish_on))
  end

  before(:each) do
    reset_newsletter
  end

  context "validations" do

    it "rejects empty pdf" do
      Newsletter.new(@valid_attributes.merge(:pdf => nil)).should_not be_valid
    end

  end

  it "has month and year" do
    news = Newsletter.new(@valid_attributes.merge({:publish_on => "20110817T00:00"}))
    news.year.should == 2011
    news.month.should == "August"
  end

  it "has current newsletter" do
    future = create_newsletter(Time.zone.now + 1.days)
    one_month_ago = create_newsletter(Time.zone.now - 1.month)
    latest = create_newsletter(Time.zone.now - 3.hours)
    one_year_ago = create_newsletter(Time.zone.now - 1.year)

    Newsletter.published.count.should == 3
    Newsletter.current.id.should == latest.id
    Newsletter.recent.first.id.should == latest.id
    Newsletter.recent[1].id.should == one_month_ago.id
    Newsletter.recent[2].id.should == one_year_ago.id
  end

end
