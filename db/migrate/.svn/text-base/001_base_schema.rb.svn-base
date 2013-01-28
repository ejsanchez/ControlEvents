class BaseSchema < ActiveRecord::Migration
  def self.up

    create_table :managers do |t|
      t.string :first_name, :null=>false
      t.string :last_name, :null=>false
      t.string :maiden_name
      t.string :login
      t.string :password
      t.string :location
      t.string :phone, :null=>false
      t.string :email, :null=>false
    end

    add_index :managers, :login, :unique=>true

    create_table :activity_types do |t|
      t.string :name, :null=>false
    end

    add_index :activity_types, :name, :unique=>true

    create_table :activities do |t|
      t.string :name, :null=>false
      t.string :description, :null=>false
      t.string :person_reg, :null=>true
      t.string :person_responsable, :null=>true
      t.string :email_contact, :null=>true
      t.string :phone_contact, :null=>true
      t.integer :activity_type_id, :null=>false
      t.integer :reservations_num, :null=>false, :default=>1
      t.integer :assistants_num, :null=>false
      t.string :opening, :null=>false, :default=>"interno"
      t.string :reach, :null=>false, :default=>"nacional"
      t.string :url
      t.string :password, :null=>false
      t.integer :status, :default=>1
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at
      t.timestamp :updated_at
    end

    add_index :activities, :name, :unique=>true

    create_table :spaces do |t|
      t.string :name, :null=>false
      t.integer :max_people, :null=>false
      t.string :location
      t.integer :manager_id , :null=>false
    end

    add_index :spaces, :name, :unique=>true

    create_table :reservations do |t|
      t.integer :activity_id
      t.integer :space_id, :null=>true
      t.integer :status, :null=>true, :default=>1
      t.date :start_date, :null=>false
      t.date :end_date, :null=>true
      t.time :start_time,  :null=>true
      t.time :end_time,  :null=>true
      t.string :schedule, :null=>true, :default => "matutino"
      t.string :details,  :null=>true
      t.string :applicant_ip
      t.timestamp :created_at
      t.timestamp :updated_at
    end

    add_index :reservations, [:activity_id, :space_id, :start_date, :schedule], :unique=>true, :name => :index_reservations_on_activity_id

    create_table :servicetypes do |t|
      t.string :name, :null=>false
    end

    add_index :servicetypes, :name, :unique=>true
 
    create_table :services do |t|
      t.string :name, :null=>false
      t.integer :servicetype_id, :null=>false
      t.string :details
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :updated_at, :null=>false
    end

    add_index :services, :name, :unique=>true

    create_table :grantings do |t|
      t.integer :activity_type_id, :null=>false
      t.integer :service_id, :null=>false
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :updated_at, :null=>false
    end

    add_index :grantings, [:activity_type_id, :service_id], :unique=>true
 
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE spaces ADD CONSTRAINT managers_id_fkey 
        FOREIGN KEY (manager_id) REFERENCES managers(id) ON DELETE CASCADE'
      execute 'ALTER TABLE activities ADD CONSTRAINT activity_types_id_fkey 
        FOREIGN KEY (activity_type_id) REFERENCES activity_types(id) ON DELETE CASCADE'
      execute 'ALTER TABLE reservations ADD CONSTRAINT reservations_activity_id_fkey 
        FOREIGN KEY (activity_id) REFERENCES activities(id) ON DELETE CASCADE'
      execute 'ALTER TABLE reservations ADD CONSTRAINT reservations_space_id_fkey 
        FOREIGN KEY (space_id) REFERENCES spaces(id) ON DELETE CASCADE'
      execute 'ALTER TABLE services ADD CONSTRAINT servicetypes_id_fkey 
        FOREIGN KEY (servicetype_id) REFERENCES servicetypes(id) ON DELETE CASCADE'
      execute 'ALTER TABLE grantings ADD CONSTRAINT grantings_activity_type_id_fkey 
        FOREIGN KEY (activity_type_id) REFERENCES activity_types(id) ON DELETE CASCADE'
      execute 'ALTER TABLE grantings ADD CONSTRAINT grantings_service_id_fkey 
        FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE'
      execute "ALTER TABLE activities ADD CONSTRAINT activity_reservations_positive
        CHECK (reservations_num > '0'::integer)"
      execute "ALTER TABLE activities ADD CONSTRAINT activity_assistants_positive
        CHECK (assistants_num > '0'::integer)"
    end
  end

   def self.down
    drop_table :grantings
    drop_table :services
    drop_table :servicetypes
    drop_table :reservations
    drop_table :spaces
    drop_table :activities
    drop_table :activity_types
    drop_table :managers
  end
end
