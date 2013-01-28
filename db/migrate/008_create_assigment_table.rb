class CreateAssigmentTable < ActiveRecord::Migration
  def self.up

    create_table :assigments do |t|
      t.integer :space_id, :null=>false
      t.integer :manager_id, :null=>false
      t.string :applicant_ip, :null=>false
      t.timestamp :created_at, :null=>false
      t.timestamp :updated_at, :null=>false
    end

    add_index :assigments, [:space_id, :manager_id], :unique=>true

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE assigments ADD CONSTRAINT space_id_forkey 
        FOREIGN KEY (space_id) REFERENCES spaces(id)'
      execute 'ALTER TABLE assigments ADD CONSTRAINT manager_id_forkey 
        FOREIGN KEY (manager_id) REFERENCES managers(id)'
    end      

  end

  def self.down
    drop_table :assigments
  end
end
