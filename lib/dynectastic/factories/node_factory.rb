module Dynectastic
  
  class NodeFactory < Resource
    
    def destroy(zone, name)
      delete("#{ entity_name }/#{ zone }/#{ name }")
    end
    
    def entity_name
      "/Node"
    end
    
  end
  
end