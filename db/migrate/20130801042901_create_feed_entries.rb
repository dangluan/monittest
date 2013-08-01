class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.text :content
      t.string :data_url
      t.integer :feed_id
      t.datetime :published
      t.string :summary
      t.string :title

      t.timestamps
    end
  end
end
