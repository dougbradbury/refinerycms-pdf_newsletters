class NewslettersController < ApplicationController

  before_filter :find_all_newsletters
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @newsletter in the line below:
    present(@page)
  end

  def show
    @newsletter = Newsletter.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @newsletter in the line below:
    present(@page)
  end

protected

  def find_all_newsletters
    @newsletters = Newsletter.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/newsletters").first
  end

end
