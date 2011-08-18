module Admin
  class NewslettersController < Admin::BaseController

    crudify :newsletter,
            :title_attribute => 'volume', :xhr_paging => true

  end
end
