require 'refinerycms-base'

module Refinery
  module PdfNewsletters
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "pdf_newsletters"
          plugin.activity = {
            :class => PdfNewsletter
          }
        end
      end
    end
  end
end
