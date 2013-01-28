# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require 'iconv'

  def replace_UTF8(field) 
    ic_ignore = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
    field = ic_ignore.iconv(field)
    ic_ignore.close

    field
  end

  def schedule_options
    '<select name="reservation[schedule]">'
     '<optgroup label="Matutino">'
       '<option value="1">08:30 - 11:00 hrs.</option>'
       '<option value="2">11:30 - 14:00 hrs.</option>'
       '<option value="3">08:30 - 14:00 hrs.</option>'
     '</optgroup>'
     '<optgroup label="Vespertino">'
       '<option value="4">16:00 - 18:00 hrs.</option>'
       '<option value="5">18:30 - 20:00 hrs.</option>'
       '<option value="6">16:00 - 20:00 hrs.</option>'
     '</optgroup>'
   '</select>'
  end

  def line_format(text)
      text.gsub!(/(^<br \/>)/, '')
      text.gsub!(/(\r\n|\n|\r)/, "\n") # lets make them newlines crossplatform
      text.gsub!(/\n\n+/, "\n\n") # zap dupes
      text.gsub!(/\n\n/, '</p>\0<p>') # turn two newlines into paragraph
      text.gsub!(/([^\n])(\n)([^\n])/, '\1\2<br />\3') # turn single newline into <br /> 
      text
  end
  
  def day_format(text)
      text.gsub!("1 ","Lunes ")
      text.gsub!("2 ","Martes ")
      text.gsub!("3 ","Miércoles ")
      text.gsub!("4 ","Jueves ")
      text.gsub!("5 ","Viernes ")
      text.gsub!("6 ","Sábado ")
      text.gsub!("0 ","Domingo ")
      text.gsub!(" 01"," Enero")
      text.gsub!(" 02"," Febrero")
      text.gsub!(" 03"," Marzo")
      text.gsub!(" 04"," Abril")
      text.gsub!(" 05"," Mayo")
      text.gsub!(" 06"," Junio")
      text.gsub!(" 07"," Julio")
      text.gsub!(" 08"," Agosto")
      text.gsub!(" 09"," Septiembre")
      text.gsub!(" 10"," Octubre")
      text.gsub!(" 11"," Noviembre")
      text.gsub!(" 12"," Diciembre")
      text
  end

  def render_menu(menu)
    "<ul>%s</ul>\n" % menu.map { |elem|
      elem[:name] ||= ''
      label = (elem[:link] ? 
               link_to(elem[:name], 
                       :controller => elem[:link][0].to_s,
                       :action => elem[:link][1].to_s) :
               elem[:name])
      children = (elem[:children] ? render_menu(elem[:children]) : '')
      '<li>%s</li>' % (label + children)
    }.join("\n")
  end

  # Menú y pie de página globales del IIEc
  def menu_iiec
    File.open('public/menu_iiec.html.part').read rescue ''
  end

  def footer_iiec
    File.open('public/footer.html.part').read rescue ''
  end
end
