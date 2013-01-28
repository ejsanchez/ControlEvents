class Space < ActiveRecord::Base

   validates_presence_of(:name, :message => 'Indique el nombre del espacio.')
   validates_presence_of(:max_people, :message => 'Indique el número máximo de asistentes que puede tener el espacio.')
   validates_presence_of(:location, :message => 'Indique la ubicación del espacio.')

   def self.manager(id)
       i = Manager.find(:first, :conditions=>["login = 'admin'"]).id
       Assigment.find(:first, :conditions => ["manager_id <> ? and space_id = ?",i,id]).manager_id
#       return a
   end

   def self.find_spaces(id)
    assig = Assigment.find(:all,:conditions => ["manager_id = ?",id])
    spaces = []
    for item in assig do
       space = find(item.space_id)
       spaces << space
    end
    return spaces
   end
end
