class Manager < ActiveRecord::Base

      validates_uniqueness_of(:login,
                              :message => 'Ya hay un usuario con este login, indique otro.')
      validates_presence_of :login, :password
      validates_confirmation_of(:password, :message => 'El password debe coincidir')

  def name
    "#{last_name}, #{maiden_name},#{first_name}"
  end

  def before_create
      self.password = Manager.crypted(self.password)
  end

#  def before_update
#      self.password = Manager.crypted(self.password)
#  end

  private

  def Manager.crypted(password)
    Digest::MD5.hexdigest(password)
  end
end
