class AssigmentsData < ActiveRecord::Migration
  class Assignment < ActiveRecord::Base;end
  def self.up
    p1 = Assigment.new(:space_id => 1,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p1.save!  
    p2 = Assigment.new(:space_id => 2,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p2.save!  
    p3 = Assigment.new(:space_id => 3,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p3.save!  
    p4 = Assigment.new(:space_id => 4,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p4.save!  
    p11 = Assigment.new(:space_id => 1,
		  :manager_id => 2,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p11.save!  
    p12 = Assigment.new(:space_id => 2,
		  :manager_id => 2,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p12.save!  
    p13 = Assigment.new(:space_id => 3,
		  :manager_id => 2,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p13.save!  
    p14 = Assigment.new(:space_id => 4,
		  :manager_id => 2,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p14.save!

    p5 = Assigment.new(:space_id => 5,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p5.save!  
    p6 = Assigment.new(:space_id => 6,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p6.save!  
    p7 = Assigment.new(:space_id => 7,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
 
    p7.save!  
    p8 = Assigment.new(:space_id => 8,
		  :manager_id => 1,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
 
    p8.save!  
    p15 = Assigment.new(:space_id => 5,
		  :manager_id => 3,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p15.save!  
    p16 = Assigment.new(:space_id => 6,
		  :manager_id => 3,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    p16.save!  
    p17 = Assigment.new(:space_id => 7,
		  :manager_id => 3,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
 
    p17.save!  
    p18 = Assigment.new(:space_id => 8,
		  :manager_id => 3,
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
 
    p18.save!  
  end

  def self.down
    Assigment.find(:all).map {|p| p.destroy}
  end
end
