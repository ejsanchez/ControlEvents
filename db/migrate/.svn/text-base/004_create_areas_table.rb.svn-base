class CreateAreasTable < ActiveRecord::Migration
  def self.up
    add_column(:activities, :area_id, :integer, :null=>true)

    create_table :areas do |t|
      t.string :name, :null=>false
    end

    add_index :areas, :name, :unique=>true

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE activities ADD CONSTRAINT area_id_fkey 
        FOREIGN KEY (area_id) REFERENCES areas(id)'
    end

  end

  def self.down
    remove_column(:activities, :area_id)
    drop_table :areas
  end
end
