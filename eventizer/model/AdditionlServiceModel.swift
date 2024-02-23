
import Foundation

class AdditionalServiceModel
{
    
     var additionalServiceId : String
     var additionalServiceName : String
     var additionalServiceLink : String
    
    
    
    init() {
      self.additionalServiceId = ""
      self.additionalServiceName = ""
      self.additionalServiceLink = ""
    
     
    }
    
    
    init(additionalServiceId : String ,
         additionalServiceName : String ,
         additionalServiceLink : String
        ) {
      self.additionalServiceId = additionalServiceId
      self.additionalServiceName = additionalServiceName
      self.additionalServiceLink = additionalServiceLink
    
    }
    
    
    init(value : NSDictionary) {
      self.additionalServiceId = value["additionalServiceId"] as! String
      self.additionalServiceName = value["additionalServiceName"] as! String
      self.additionalServiceLink = value["additionalServiceLink"] as! String
     
    }
    
    
    func toDictionary() -> Any {
      return [
        "additionalServiceId" : self.additionalServiceId,
        "additionalServiceName" : self.additionalServiceName,
        "additionalServiceLink" : self.additionalServiceLink
       
      ] as Any
    }
}
