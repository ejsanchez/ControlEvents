class OrderMailer < ActionMailer::Base

  def confirm(id,pconf)
    space = Activity.space_asked(id)
    subject    'IIEc-Actividades(alta de solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id), :pconf => pconf
    recipients [Activity.find(id).email_contact]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def notify(id)
    space = Activity.space_asked(id)
    @managers = secman_mails
    @admor = Manager.find(Space.manager(space))
    @admin = Manager.find(:first,:conditions=>"login='admin'")
    subject    'IIEc-Actividades(alta de solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id), :admor => Manager.find(Space.manager(space))
    recipients [@admor.email,@admin.email,@managers]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def change(id)
    space = Activity.space_asked(id)
    @admor = Manager.find(Space.manager(space))
    @admin = Manager.find(:first,:conditions=>"login='admin'")
    subject    'IIEc-Actividades(cambio en solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id), :admor => Manager.find(Space.manager(space))
    recipients [@admor.email,@admin.email]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def cansession(id)
    @manager = Manager.find(:first,:conditions=>"login='admin'").email
    @suppliers = suppliers_mails
    subject    'IIEc-Actividades(cancelación de sesión en solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id)
    recipients [@suppliers,@manager]  
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def cancel_by_own(id)
    @suppliers = suppliers_mails
    @manager = Manager.find(:first,:conditions=>"login='admin'").email
    subject    'IIEc-Actividades(cancelación de solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id)
    recipients [@suppliers,@manager]  
#    recipients [Activity.find(id).email_contact, 'jereyes@servidor.unam.mx', 'pedrazam@servidor.unam.mx','jllopez@iiec.unam.mx','jrodriguez@iiec.unam.mx','ccruz@iiec.unam.mx',@manager]
#    recipients ['esanchez@iiec.unam.mx',@manager]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def cancel_by_adm(id)
    @suppliers = suppliers_mails
    @manager = Manager.find(:first,:conditions=>"login='admin'").email
    subject    'IIEc-Actividades(cancelación de solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id)
    recipients [Activity.find(id).email_contact,@manager,@suppliers]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def authorization(id)
    space = Activity.space_asked(id)
    @manager = Manager.find(Space.manager(space))
    @admin = Manager.find(:first,:conditions=>"login='admin'").email
    subject    'IIEc-Actividades(autorización de solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id)
    recipients  [Activity.find(id).email_contact,@manager.email,@admin]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def authorization_serv(id)
    @suppliers = suppliers_mails
    subject    'IIEc-Actividades(nueva orden de trabajo para la solicitud ' + id.to_s + ')'
    body       :activity => Activity.find(id)
    recipients [@suppliers]  
#    recipients ['jereyes@servidor.unam.mx', 'pedrazam@servidor.unam.mx','jllopez@iiec.unam.mx','jrodriguez@iiec.unam.mx','ccruz@iiec.unam.mx']
#    recipients ['esanchez@iiec.unam.mx']
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  def advice(name,email,phone,text)
    @manager = Manager.find(:first,:conditions=>"login='admin'")
    subject    'IIEc-Actividades(sugerencia)'
    body       :cont => text, :name => name, :phone=> phone, :email => email
    recipients [@manager.email]
    from       'no-reply@iiec.unam.mx'
    sent_on    Time.now
    content_type "text/plain"
  end

  private

  def suppliers_mails
    @suppliers = Supplier.find(:all)
    @destinations = []
    for item in @suppliers do
       @destinations << item.email
    end
    @mails = @destinations.join(',')
    return @mails
  end

  def secman_mails
    @managers = Manager.find(:all,:conditions=>"role=2")
    @destinations = []
    for item in @managers do
       @destinations << item.email
    end
    @mails = @destinations.join(',')
    return @mails
  end
end
