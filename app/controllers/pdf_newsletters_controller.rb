class PdfNewslettersController < ApplicationController

  helper :pdf_newsletters
  before_filter :find_all_newsletters
  before_filter :find_page

  def index
    present(@page)
  end

  def show
    @newsletter = PdfNewsletter.find(params[:id])
    redirect_to @newsletter.pdf.url
  end

protected

  def find_all_newsletters
    @newsletters = PdfNewsletter.recent
  end

  def find_page
    @page = Page.where(:link_url => "/pdf_newsletters").first
  end

end
