class AreasCatalog < ActiveRecord::Migration
  class Area < ActiveRecord::Base;end
  class ActivityType < ActiveRecord::Base;end
  def self.up
    a1 = Area.new(:name => 'Economía Mundial')
    a1.save!
    a2 = Area.new(:name => 'Economía Industrial')
    a2.save!
    a3 = Area.new(:name => 'Economía del Sector Primario')
    a3.save!
    a4 = Area.new(:name => 'Economía Urbana y Regional')
    a4.save!
    a5 = Area.new(:name => 'Economía Aplicada')
    a5.save!
    a6 = Area.new(:name => 'Economía del Trabajo y de la Tecnología')
    a6.save!
    a7 = Area.new(:name => 'Historia Económica ')
    a7.save!
    a8 = Area.new(:name => 'Economía Fiscal y Financiera')
    a8.save!
    a9 = Area.new(:name => 'Economía de la Educación, la Ciencia y la Tecnología')
    a9.save!
    a10 = Area.new(:name => 'Economía del Sector Energético')
    a10.save!
    a11 = Area.new(:name => 'Economía Política del Desarrollo')
    a11.save!
    a12 = Area.new(:name => 'Estudios Hacendarios y del Sector Público')
    a12.save!
    a13 = Area.new(:name => 'Economía del Conocimiento y Desarrollo')
    a13.save!
    a14 = Area.new(:name => 'Economía y Medio Ambiente')
    a14.save!
    a15 = Area.new(:name => 'Departamento de Estudios Prospectivos y de coyuntura')
    a15.save!
    a16 = Area.new(:name => 'Centro de Educación Continua')
    a16.save!
    a17 = Area.new(:name => 'Secretaría Académica')
    a17.save!
    a18 = Area.new(:name => 'Secretaría Técnica')
    a18.save!
    a19 = Area.new(:name => 'Secretaría Administrativa')
    a19.save!
    a20 = Area.new(:name => 'Dirección')
    a20.save!

    b10 = ActivityType.new(:name => 'Videoconferencia')
    b10.save!
    b11 = ActivityType.new(:name => 'Rueda de prensa')
    b11.save!

  end

  def self.down
    Area.find(:all).map {|a| a.destroy}
    ActivityType.find(:all).map {|b| b.destroy}
  end
end
