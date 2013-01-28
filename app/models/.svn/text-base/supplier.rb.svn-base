class Supplier < ActiveRecord::Base

   belongs_to :servicetype

   validates_uniqueness_of(:email,:message => 'Ya hay un usuario con este email, indique otro.')
   validates_presence_of(:first_name, :last_name,:phone,:email,:message=>'Todos los campos marcados deben ser informados.')
   validates_associated :servicetype

  def name
    "#{last_name}, #{maiden_name},#{first_name}"
  end

end
