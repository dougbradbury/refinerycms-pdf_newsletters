module Admin
  class PdfNewslettersController < Admin::BaseController

    crudify :pdf_newsletter,
            :title_attribute => 'publish_on', :xhr_paging => true

  end
end
