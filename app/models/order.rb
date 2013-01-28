class Order
   attr_reader :newactivity
   attr_reader :newreservation
   attr_reader :space_asked

   def initialize
       empty!
   end

   def empty!
      @newactivity = []
      @newreservation = []
      @space_asked = []
   end
end

