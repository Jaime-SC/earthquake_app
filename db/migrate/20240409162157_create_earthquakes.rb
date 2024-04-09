class CreateEarthquakes < ActiveRecord::Migration[7.1]
  def change
    create_table :earthquakes, id: false do |t|
      t.string :id, primary_key: true
      t.float :mag
      t.string :place
      t.string :time
      t.string :url
      t.boolean :tsunami
      t.string :mag_type
      t.string :title
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
