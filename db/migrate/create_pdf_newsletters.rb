class CreateNewsletters < ActiveRecord::Migration

  def self.up
    create_table :newsletters do |t|
      t.datetime :publish_on
      t.integer :pdf_id
      t.string :volume
      t.string :issue
      t.integer :position
      t.string :editor

      t.timestamps
    end

    add_index :newsletters, :id

    load(Rails.root.join('db', 'seeds', 'newsletters.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "newsletters"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/newsletters"})
    end

    drop_table :newsletters
  end

end
