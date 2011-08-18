class PdfNewslettersController < ApplicationController

  helper :pdf_newsletters
  before_filter :find_all_newsletters
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @newsletter in the line below:
    present(@page)
  end

  def show
    @newsletter = PdfNewsletter.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @newsletter in the line below:
    present(@page)
  end

protected

  def find_all_newsletters
    @newsletters = PdfNewsletter.recent
  end

  def find_page
    @page = Page.where(:link_url => "/pdf_newsletters").first
  end

end
