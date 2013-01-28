class AddFields < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :first_name, :null=>false
      t.string :last_name, :null=>false
      t.string :maiden_name
      t.string :location
      t.integer :servicetype_id, :null=>false
      t.string :phone, :null=>false
      t.string :email, :null=>false
    end

    add_index :suppliers, :email, :unique=>true

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE suppliers ADD CONSTRAINT service_type_id_fkey 
        FOREIGN KEY (servicetype_id) REFERENCES servicetypes(id)'
    end

  end

  def self.down
    drop_table :suppliers
  end
end
