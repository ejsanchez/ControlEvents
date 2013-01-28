class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.date :app_date, :null=>false
      t.date :app_date_end, :null=>true
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :updated_at, :null=>false
    end

    add_index :holidays, :app_date, :unique=>true

    create_table :signs do |t|
      t.integer :activity_id, :null=>false
      t.string :sign, :null=>false
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :updated_at, :null=>false
    end

    add_index :signs, :activity_id, :unique=>true

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE signs ADD CONSTRAINT activities_id_fkey 
        FOREIGN KEY (activity_id) REFERENCES activities(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :holidays
    drop_table :signs
  end
end
