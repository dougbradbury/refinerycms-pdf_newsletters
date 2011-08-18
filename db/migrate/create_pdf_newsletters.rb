class CreatePdfNewsletters < ActiveRecord::Migration

  def self.up
    create_table :pdf_newsletters do |t|
      t.datetime :publish_on
      t.integer :pdf_id
      t.string :volume
      t.string :issue
      t.integer :position
      t.string :editor

      t.timestamps
    end

    add_index :pdf_newsletters, :id

    load(Rails.root.join('db', 'seeds', 'pdf_newsletters.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "pdf_newsletters"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/pdf_newsletters"})
    end

    drop_table :pdf_newsletters
  end

end
