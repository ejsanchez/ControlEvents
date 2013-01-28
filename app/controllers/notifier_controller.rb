class NotifierController < ApplicationController  
  require 'iconv'

  def create_order
#     session[:strcap] = nil
     email = OrderMailer.deliver_confirm(params[:id],params[:pconf])
     emailb = OrderMailer.deliver_notify(params[:id])
     redirect_to(:action=>'permit_access', :controller=>'activities', :id => params[:id], :pconf => session[:strcap], :context=>"registration")
     flash[:message] << 'Su solicitud ha sido registrada exitosamente.<br/>' 
#     redirect_to_index('Su solicitud ha sido registrada exitosamente.<br/>')
#     render(:text => "<pre>" + params[:pconf] + email.encoded + emailb.encoded + "</pre>")   
  end

  def notify_change
     email = OrderMailer.deliver_change(params[:id])
     if params[:context]== 'cancelses'
        email = OrderMailer.deliver_cansession(params[:id])
     end 
     flash[:message] = 'La reservación ha sido actualizada con éxito, pero se le retira la autorización a la actividad, por lo que quedará nuevamente sujeta a revisión.<br/>'       
     redirect_to(:action=>'show', :controller => 'activities', :id => params[:id]) 
  end

  def notify_cansession
  end

  def save_advice
  end

  def send_advice          
     email = OrderMailer.deliver_advice(params[:name],params[:email],params[:phone],params[:content])
     flash[:message] = 'Su sugerencia ha sido entregada al administrador de este sitio, gracias por su tiempo.<br/>'       
     redirect_to(:action=>'index', :controller => 'consult')  
#     render(:text => "<pre>" + email.encoded + "</pre>")   
  end

  def notify_cancel_act
     if session[:manager_id] == nil        
        email = OrderMailer.deliver_cancel_by_own(params[:id])
        flash[:message] = 'La actividad ha sido cancelada con éxito, el cambio se le notificará a los responsables de servicios.<br/>'  
        redirect_to :action => 'index', :controller => 'registration'
     else
        email = OrderMailer.deliver_cancel_by_adm(params[:id])
        flash[:message] = 'La actividad ha sido cancelada con éxito.<br/>'  
        redirect_to :action => 'show', :controller => 'authorize',:context=>"#{params[:context]}"
     end
#     render(:text => "<pre>" + email.encoded + "</pre>")   
  end

  def notify_auth
     email = OrderMailer.deliver_authorization(params[:id])
     emailb = OrderMailer.deliver_authorization_serv(params[:id])
     flash[:message] = 'La solicitud ha sido autorizada exitosamente.'
     redirect_to :action => 'show', :controller => 'authorize', :context=>"unauthorized"
#     render(:text => "<pre>" + email.encoded + emailb.encoded + "</pre>")   
  end

  def pdf
    send_data gen_pdf(params[:id]), :filename => "solicitud_" + params[:id] + ".pdf", :type => "application/pdf"
  rescue
    logger.error("Intenta ver una solicitud inexistente #{params[:id]}")
    flash[:notice] = "No existe ninguna solicitud válida con este número de folio: #{params[:id]}"
    redirect_to_index
  end

 private
  def gen_pdf(id)
    act = Activity.find(id)
    reservations = Activity.reservations(id)
    grantings = Granting.find(:all,:conditions => ["activity_type_id = ?",act.activity_type_id])

# Creacion dela instancia para el archivo    
    pdf=FPDF.new
    pdf.AddPage
    pdf.SetTitle("Solicitud_" + act.id.to_s)
# Definición del encabezado del documento
    pdf.Image('public/images/logo_unam.jpg',10,10,30)
    pdf.Cell(28)
    pdf.SetFont('Arial','B',15)
    pdf.Cell(45,10,replace_UTF8("UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO"))
    pdf.Image('public/images/logo_iiec3.jpg',170,10,30)
    pdf.SetFont('Arial','B',12)
    pdf.Ln(6)
    pdf.Cell(43)
    pdf.Cell(45,10,replace_UTF8("INSTITUTO DE INVESTIGACIONES ECONÓMICAS"))
    pdf.Ln(5)    
    pdf.Cell(87)
    pdf.Cell(45,10,"213.01")
    pdf.Ln(5)
    pdf.Cell(59)
    pdf.Cell(40,10,"SECRETARIA ADMINISTRATIVA")
    pdf.SetFont('Arial','B',10)
    pdf.Ln(6)
    pdf.Cell(70)
    pdf.Cell(40,10,"SERVICIOS GENERALES")
    pdf.Ln(7)
    pdf.Cell(59)
    pdf.Cell(40,10,"SOLICITUD DE SERVICIOS DIVERSOS")
    pdf.Ln(12)
#    pdf.Cell(100,3,"___________________________________________________________",0,1)
# Definicion del cuerpo del documento con base a la actividad solicitada
    pdf.SetFont('Arial','B',10)    
    pdf.Cell(25,5,"No DE FOLIO   ",0,0,'L')
    pdf.Cell(40,5,id,1,0,'C')
    pdf.Cell(40,5,"",0,0,'C')
    pdf.Cell(50,5,"FECHA DE SOLICITUD:",0,0,'L')
    pdf.Cell(35,5,act.created_at.strftime("%d-%m-%Y"),1,0,'C')
    pdf.Ln(8)
    pdf.Cell(25,5,"ESTATUS   ",0,0,'L')
    if act.num_asses == 1
       pdf.Cell(40,5,replace_UTF8("Nueva - " + Activity.st_status(act.status)),1,0,'C')
    else
       pdf.Cell(40,5,replace_UTF8("Modificada -" + Activity.st_status(act.status)),1,0,'C')
    end
    pdf.Cell(40,5,"",0,0,'C')
    if act.num_asses > 1
       pdf.Cell(50,5,replace_UTF8("FECHA DE MODIFICACIÓN:"),0,0,'L')
       pdf.Cell(35,5,act.updated_at.strftime("%d-%m-%Y"),1,0,'C')
       pdf.Ln(8)
       pdf.Cell(105,5,"",0,0,'L')
       pdf.Cell(50,5,replace_UTF8("MODIFICACIÓN No.:"),0,0,'L')
       pdf.Cell(35,5,act.num_asses.to_s,1,0,'C')
    end

    pdf.Ln(8)
    pdf.SetFont('Arial','B',10)    
# Información del responsable de la actividad
    pdf.SetFont('Arial','',10)    
    pdf.Cell(23)
    pdf.Cell(60,10,"UNIDAD RESPONSABLE ")
    pdf.Cell(10,10,replace_UTF8(Area.find(act.area_id).name))
    pdf.Ln(6)
    pdf.Cell(23)
    pdf.Cell(60,10,"NOMBRE DEL RESPONSABLE ",0,0)
    pdf.Cell(10,10,replace_UTF8(act.person_responsable))
    pdf.Ln(6)
    pdf.Cell(23)
    pdf.Cell(60,10,"TELEFONO ")
    pdf.Cell(10,10,act.phone_contact)
    pdf.Ln(11)
    pdf.Cell(23)
#    pdf.Cell(60,10,"Correo electronico: ")
#    pdf.Cell(10,10,act.email_contact)
    pdf.SetFont('Arial','B',11)  
    pdf.Cell(60,10,"TIPO DE SERVICIO ",0,0)
    pdf.Ln(10)
    pdf.Cell(23)
    pdf.SetFont('Arial','',10)  
    pdf.Cell(40,10,"SALA",0,0)         
    pdf.SetFont('Arial','B',10)  
    pdf.Cell(6,6,"X",1,0,'C')      
    pdf.Cell(10)   
    pdf.SetFont('Arial','',10)  
    pdf.Cell(40,10,"LIMPIEZA",0,0)         
    pdf.SetFont('Arial','B',10)  
    pdf.Cell(6,6,"X",1,0,'C')         
    pdf.Cell(10)   
    pdf.SetFont('Arial','',10)  
    pdf.Cell(20,10,"OTROS",0,0)         
    pdf.SetFont('Arial','B',10)  
    pdf.Cell(35,6,"",'B',0,'C')         
    pdf.Ln(8)
    pdf.SetFont('Arial','',10)  
    pdf.Cell(23)
    pdf.Cell(47,10,"TIPO DE ACTIVIDAD ",0,0)
    pdf.Cell(10,10,replace_UTF8(ActivityType.find(act.activity_type_id).name))
    pdf.Ln(8)
    pdf.Cell(23)
    pdf.Cell(47,8,"TITULO ",0,0)
    pdf.MultiCell(0,4,replace_UTF8(act.name))
    pdf.Ln(5)
    pdf.Cell(23)
    pdf.Cell(47,8,"PARTICIPANTES ",0,0)
    pdf.MultiCell(0,4,replace_UTF8(act.participants))
    pdf.Ln(5)
    pdf.SetFont('Arial','B',11)  
    pdf.Cell(23)
    pdf.Cell(60,10,"DESCRIPCION DEL SERVICIO ",0,0)
    pdf.SetFont('Arial','',9)  
    pdf.Ln(10)
    pdf.Cell(13,6,replace_UTF8("SESIÓN"),'BR',0,'C')      
    pdf.Cell(16,6,"FECHA",'BR',0,'C')      
    pdf.Cell(18,6,"HORARIO",'BR',0,'C')      
    pdf.Cell(50,6,"SALA",'BR',0,'C')      
    pdf.Cell(18,6,"PONENTES",'BR',0,'C')      
    pdf.Cell(21,6,"ASISTENTES",'BR',0,'C')      
    pdf.Cell(50,6,replace_UTF8("DETALLES DE LA SESIÓN"),'B',0,'C')      
    pdf.Ln()
    pdf.SetFont('Arial','',9)  
    count = 0
    for item in reservations do 
      if item.status < 3   
        count = count + 1 
        pdf.SetFont('Arial','',8)  
        pdf.Cell(13,6,count.to_s,'R',0,'C') 
        pdf.Cell(16,6,item.start_date.strftime("%d-%m-%Y"),'R',0,'C') 
        pdf.Cell(18,6,item.start_time.strftime("%H:%M") + ' - ' + item.end_time.strftime("%H:%M"),'R',0,'C') 
        pdf.Cell(50,6,replace_UTF8(Space.find(item.space_id).name),'R',0,'C')
        pdf.Cell(18,6,item.num_rapporteurs.to_s,'R',0,'C')
        pdf.Cell(21,6,item.assistants_num.to_s,'R',0,'C')
        pdf.MultiCell(0,3,replace_UTF8(item.details),0,'L')
        pdf.Ln()
      end
    end
    pdf.Ln(5)
    pdf.Cell(23)
    pdf.SetFont('Arial','B',10)  
    pdf.Cell(50,10,"SERVICIOS GARANTIZADOS",0,0)
    pdf.Ln()
    pdf.SetFont('Arial','',9)  
    if grantings.size > 0
      for item in grantings do
        pdf.Cell(23)    
        pdf.Cell(50,3,replace_UTF8(Service.find(item.service_id).name))         
        pdf.Ln()
      end    
    else
        pdf.Cell(23)    
        pdf.Cell(50,3,"No cuenta con servicios garantizados.")         
        pdf.Ln()
    end
    pdf.SetFont('Arial','',10)      
    pdf.Ln(5)
    pdf.Cell(23)
    pdf.Cell(50,10,"FIRMA DE CONFORMIDAD ",0,0)
    pdf.Cell(40,7,"",'B',0)
    pdf.Ln(13)
    pdf.SetFont('Arial','B',10)    
    pdf.Cell(25,5,"OBSERVACIONES: ",0,0,'L')
    pdf.Ln()
    pdf.SetFont('Arial','',10)
    pdf.MultiCell(0,6,replace_UTF8(act.observations.to_s),1,'J')
    pdf.SetFont('Arial','B',10)
    pdf.Ln(10)
    pdf.Cell(10)
    pdf.Cell(50,10,replace_UTF8("RECIBIÓ"),0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,10,replace_UTF8("SUPERVISÓ"),0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,10,replace_UTF8("AUTORIZÓ"),0,0,'C')
    pdf.Ln(10)
    pdf.Cell(10)
    pdf.Cell(50,10,"",'B',0,'J')
    pdf.Cell(10)
    pdf.Cell(50,10,"",'B',0,'J')
    pdf.Cell(10)
    pdf.Cell(50,10,"",'B',0,'J')
    pdf.Ln()
    pdf.Cell(10)
    pdf.Cell(50,5,"NOMBRE Y FIRMA",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"NOMBRE Y FIRMA",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"NOMBRE Y FIRMA",0,0,'C')
    pdf.Ln()
    pdf.Cell(10)
    pdf.SetFont('Arial','',10)    
    pdf.Cell(50,5,"PERSONAL OPERATIVO",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"RESPONSABLES DE",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"SECRETARIO ADMINISTRATIVO /",0,0,'C')
    pdf.Ln()
    pdf.Cell(10)
    pdf.Cell(50,5,"",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"SERVICIOS GENERALES",0,0,'C')
    pdf.Cell(10)
    pdf.Cell(50,5,"JEFE DE UNIDAD ADMINISTRATIVA",0,0,'C')

#    pdf.Cell(10,10,"Dirigido a: ",0,0)
#    pdf.Cell(25)
#    pdf.Cell(10,10,act.opening)
#    pdf.Ln(5)
#    pdf.Cell(10,10,"Alcance: ",0,0)
#    pdf.Cell(25)
#    pdf.Cell(10,10,act.reach)

    pdf.Output
#    act.observations = pdf
#    if act.update_attribute(:status,2)                         
#       redirect_to :action=>'create_order', :controller=>'notifier', :id => act.id
#       flash[:message] = 'Su solicitud ha sido registrada exitosamente.<br/>'
#    else  
#       flash[:notice] = 'Error al registrar la actividad.<br/>' << @act.errors.full_messages.join('<br/>')                                     
#       redirect_to(:action=>'index')
#    end
  end

  def replace_UTF8(field) 
    ic_ignore = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
    field = ic_ignore.iconv(field)
    ic_ignore.close

    field
  end

end
