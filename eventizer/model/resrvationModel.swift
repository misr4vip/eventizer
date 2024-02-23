import Foundation

struct ResrvationModel
{
     var resId : String
     var storeId : String
     var resDate : String
     var clientId : String
     var price : String
     var isResrved : Bool
     var isConfirmed : Bool
    
    
    init() {
      self.resId = ""
      self.storeId = ""
      self.resDate = ""
      self.isResrved = false
      self.isConfirmed = false
      self.price = ""
      self.clientId = ""
     
    }
    
    
    init(resId : String ,
         storeId : String ,
         clientId : String,
         resDate : String ,
         price : String ,
         isResrved : Bool ,
         isConfirmed : Bool) {
      self.resId = resId
      self.storeId = storeId
      self.resDate = resDate
      self.isResrved = isResrved
      self.isConfirmed = isConfirmed
      self.price = price
      self.clientId = clientId
        
    }
    
    
    init(value : NSDictionary) {
      self.resId = value["resId"] as! String
      self.storeId = value["storeId"] as! String
      self.price = value["price"] as! String
      self.resDate = value["resDate"] as! String
      self.isResrved = value["isResrved"] as! Bool
      self.isConfirmed = value["isConfirmed"] as! Bool
      self.clientId = value["clientId"] as! String
        
    }
    
    
    func toDictionary() -> Any {
      return [
        "resId" : self.resId,
        "storeId" : self.storeId,
        "clientId" : self.clientId,
        "resDate" : self.resDate,
        "price" : self.price,
        "isResrved" : self.isResrved,
        "isConfirmed" : self.isConfirmed
       
      ] as Any
    }
}
