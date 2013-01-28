class CatalogData < ActiveRecord::Migration
  class ActivityType < ActiveRecord::Base; end
  class Manager < ActiveRecord::Base; end
  class Space < ActiveRecord::Base; end
  class Service < ActiveRecord::Base; end
  class ServiceType < ActiveRecord::Base; end
  def self.up

    a1 = ActivityType.new(:name => 'Conferencia')
    a1.save!
    a2 = ActivityType.new(:name => 'Seminario Institucional')
    a2.save!
    a3 = ActivityType.new(:name => 'Taller')
    a3.save!
    a4 = ActivityType.new(:name => 'Diplomado')
    a4.save!
    a5 = ActivityType.new(:name => 'Mesa redonda')
    a5.save!
    a6 = ActivityType.new(:name => 'Presentación de libro')
    a6.save!
    a7 = ActivityType.new(:name => 'Curso')
    a7.save!
    a8 = ActivityType.new(:name => 'Homenaje')
    a8.save!
    a9 = ActivityType.new(:name => 'Entrega de premio')
    a9.save!

    m1 = Manager.new(:first_name => 'Evelyn',
                  :last_name =>'Sánchez',
                  :maiden_name => 'Fragoso',
		  :login => 'admin',
                  :password => 'controlEvents',
                  :location => 'Sría.Técnica',
		  :phone => '56230100 ext 42489',
		  :email => 'esanchez@iiec.unam.mx')
    m1.save!

    m2 = Manager.new(:first_name => 'Verónica',
                  :last_name =>'Calleros',
                  :maiden_name => 'López',
		  :login => 'vcalleros',
                  :password => 'vcalleros',
                  :location => 'Difusión',
		  :phone => '56230099',
		  :email => 'esanchez@iiec.unam.mx')
    m2.save!

    m3 = Manager.new(:first_name => 'Aristeo',
                  :last_name =>'Tovías',
                  :maiden_name => 'García',
		  :login => 'atovias',
                  :password => 'atovias',
                  :location => 'Secretaría Técnica',
		  :phone => '56230157',
		  :email => 'esanchez@iiec.unam.mx')
    m3.save!

    p1 = Space.new(:name => 'Auditorio Ricardo Torres Gaitán',
                  :max_people => 100,
                  :location => 'PBD',
		  :manager_id => 1)
    p1.save!

    p2 = Space.new(:name => 'Sala de videoconferencias',
                  :max_people => 30,
                  :location => 'PBD',
		  :manager_id => 1)
    p2.save!

    p3 = Space.new(:name => 'Sala Ángel Bassols',
                  :max_people => 40,
                  :location => 'PBD',
		  :manager_id => 1)
    p3.save!

    p4 = Space.new(:name => 'Sala José Luis Ceceña',
                  :max_people => 30,
                  :location => 'PBD',
		  :manager_id => 1)
    p4.save!

    p5 = Space.new(:name => 'Laboratorio de cómputo 1',
                  :max_people => 10,
                  :location => '1PI',
		  :manager_id => 2)
    p5.save!

    p6 = Space.new(:name => 'Laboratorio de cómputo 2',
                  :max_people => 25,
                  :location => '1PI',
		  :manager_id => 2)
    p6.save!

    p7 = Space.new(:name => 'Aula 1',
                  :max_people => 20,
                  :location => '1PD',
		  :manager_id => 2)
    p7.save!

    p8 = Space.new(:name => 'Aula 2',
                  :max_people => 20,
                  :location => '1PD',
		  :manager_id => 2)
    p8.save!

    t1 = Servicetype.new(:name => 'Administrativos')
    t1.save!

    t2 = Servicetype.new(:name => 'Técnicos')
    t2.save!

    t3 = Servicetype.new(:name => 'Académicos')
    t3.save!

    s1 = Service.new(:name => 'Micrófonos alámbricos',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s1.save!

    s2 = Service.new(:name => 'Micrófonos de solapa',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s2.save!
    s3 = Service.new(:name => 'Proyector multimedia',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s3.save!

    s4 = Service.new(:name => 'Laptop',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s4.save!
    s5 = Service.new(:name => 'Televisión',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s5.save!
    s6 = Service.new(:name => 'Reproductor de DVD',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s6.save!
    s7 = Service.new(:name => 'Videocasetera VHS',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s7.save!
    s8 = Service.new(:name => 'Pantalla de proyección',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s8.save!
    s9 = Service.new(:name => 'Proyector de acetatos',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s9.save!
    s10 = Service.new(:name => 'Proyector de transparencias',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s10.save!
    s11 = Service.new(:name => 'Proyector de cuerpos opacos',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s11.save!

    s12 = Service.new(:name => 'Toma de fotografías',
                  :servicetype_id =>2,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s12.save!

    s13 = Service.new(:name => 'Mesa para registro',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s13.save!

    s14 = Service.new(:name => 'Mesa para cafetería',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s14.save!

    s15 = Service.new(:name => 'Agua en botella para ponentes',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s15.save!

    s16 = Service.new(:name => 'Agua en jarra para ponentes',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s16.save!

    s17 = Service.new(:name => 'Té para ponentes',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s17.save!

    s18 = Service.new(:name => 'Servicio de cafetería',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s18.save!

    s19 = Service.new(:name => 'Colocación de podium',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s19.save!

    s20 = Service.new(:name => 'Servicio de limpieza',
                  :servicetype_id =>1,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s20.save!

    s21 = Service.new(:name => 'Paño con logotipo del instituto',
                  :servicetype_id =>3,
                  :details => '',
		  :applicant_ip => '132.248.72.141',
                  :created_at => '2008-02-21 11:32:00',
                  :updated_at => '2008-02-21 11:32:27')
    s21.save!


  end

  def self.down
    Activity_type.find(:all).map {|a| a.destroy}
    Manager.find(:all).map {|m| m.destroy}
    Space.find(:all).map {|p| p.destroy}
    Servicetype.find(:all).map {|t| t.destroy}
    Service.find(:all).map {|c| c.destroy}
  end
end
