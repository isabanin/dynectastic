module Dynectastic
  
  class NodeFactory < Resource
    
    def destroy(zone, name)
      delete("#{ entity_base }/#{ zone }/#{ name }")
    end
    
    def entity_base
      "/REST/Node"
    end
    
  end
  
end