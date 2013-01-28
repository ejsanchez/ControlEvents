class SuppliersData < ActiveRecord::Migration
  class Supplier < ActiveRecord::Base;end
  def self.up
    s1 = Supplier.new(:first_name => 'Ernesto',
                  :last_name =>'Reyes',
                  :maiden_name => 'Guzmán',
                  :location => 'P1I',
                  :servicetype_id =>2,
		  :phone => '56230122',
		  :email => 'jereyes@servidor.unam.mx')
    s1.save!

    s2 = Supplier.new(:first_name => 'Carlos',
                  :last_name =>'Cruz',
                  :maiden_name => 'Barrera',
                  :location => 'PBD',
                  :servicetype_id =>2,
		  :phone => '56230100 ext. 42471',
		  :email => 'ccruz@iiec.unam.mx')
    s2.save!

    s3 = Supplier.new(:first_name => 'Julio',
                  :last_name =>'Rodríguez',
                  :maiden_name => 'Sánchez',
                  :location => 'P1D',
                  :servicetype_id =>2,
		  :phone => '56230100 ext. 42486',
		  :email => 'jrodriguez@iiec.unam.mx')
    s3.save!

    s4 = Supplier.new(:first_name => 'José Luis',
                  :last_name =>'López',
                  :maiden_name => 'Castillo',
                  :location => 'P1D',
                  :servicetype_id =>2,
		  :phone => '56230100 ext. 42486',
		  :email => 'jllopez@iiec.unam.mx')
    s4.save!

    s5 = Supplier.new(:first_name => 'Alberto',
                  :last_name =>'Pedraza',
                  :maiden_name => 'Martínez',
                  :location => 'P1D',
                  :servicetype_id =>1,
		  :phone => '56230143 - 144',
		  :email => 'pedrazam@iiec.unam.mx')
    s5.save!
  end

  def self.down
    Supplier.find(:all).map {|s| s.destroy}
  end
end
