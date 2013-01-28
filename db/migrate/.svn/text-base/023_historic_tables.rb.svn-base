class HistoricTables < ActiveRecord::Migration
  def self.up
    create_table :advance_days do |t|
      t.integer :days, :null=>false
      t.string :applicant_ip, :null=>true
      t.timestamp :created_at, :null=>true
      t.timestamp :updated_at, :null=>true
    end

    create_table :old_activities, :id=>false do |t|
      t.integer :id, :null=>false
      t.string :name, :null=>true
      t.text :description, :null=>true
      t.string :person_reg, :null=>true
      t.string :person_responsable, :null=>true
      t.string :email_contact, :null=>true
      t.string :phone_contact, :null=>true
      t.integer :activity_type_id, :null=>true
      t.integer :reservations_num, :null=>true, :default=>1
      t.integer :assistants_num, :null=>true
      t.string :opening, :null=>true, :default=>"interno"
      t.string :reach, :null=>true, :default=>"nacional"
      t.string :url, :null=>true
      t.string :password, :null=>true, :null=>false
      t.integer :status, :null=>true, :default=>1
      t.string :observations, :null=>true
      t.integer :area_id, :null=>true
      t.boolean :published, :null => true, :default => false
      t.text :participants, :null => true
      t.text :institutions, :null => true
      t.string :applicant_ip, :null=>true
      t.timestamp :created_at, :null=>true
      t.timestamp :updated_at, :null=>true
    end

    create_table :old_reservations, :id=>false do |t|
      t.integer :id, :null=>false
      t.integer :activity_id
      t.integer :space_id, :null=>true
      t.integer :status, :null=>true, :default=>1
      t.date :start_date, :null=>true
      t.date :end_date, :null=>true
      t.time :start_time,  :null=>true
      t.time :end_time,  :null=>true
      t.string :schedule, :null=>true, :default => "matutino"
      t.text :details,  :null=>true
      t.integer :assistants_num, :null=>true
      t.integer :num_rapporteurs, :null=>true, :default=>0
      t.string :applicant_ip, :null=>true
      t.timestamp :created_at, :null=>true
      t.timestamp :updated_at, :null=>true
    end
  end

  def self.down
    drop_table :advance_days
    drop_table :old_activities
    drop_table :old_reservations
  end
end
