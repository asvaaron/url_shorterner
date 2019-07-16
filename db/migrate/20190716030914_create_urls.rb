class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :title, limit: 500
      t.text :url
      t.string :short_url, limit: 350
      t.integer :times_accessed

      t.timestamps
    end
    add_index :urls, :url, unique: true
  end
end
