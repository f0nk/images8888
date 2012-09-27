class CreateItems < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.text :title
      t.text :keywords
      t.text :description
      t.string :source
      t.string :article_url

      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
