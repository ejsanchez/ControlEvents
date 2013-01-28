class ActivityType < ActiveRecord::Base

  def self.grantings(id)
      @grants=Granting.find(:all,:conditions=>["activity_type_id=?", id])
      @servs=""
      @servid=[]      
      if @grants.size > 0
        for item in @grants 
           @servid <<  item.service_id
#           @servs = @servs + '<li>' + Service.find(item.service_id).name + '</li>'
        end
        @srs=Service.find(:all,:conditions=>["id IN (?)",@servid],:order=>'priority')
        for item in @srs
           @servs = @servs + '<li>' + Service.find(item.id).name + '</li>'
        end        
      else
        @servs = "Esta actividad no tiene servicios garantizados."
      end
      @servs
  end

end
