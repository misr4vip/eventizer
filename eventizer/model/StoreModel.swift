

import Foundation

struct StoreModel
{
    var storeId : String = ""
     var storeName : String = ""
     var discription : String = ""
     var email : String = ""
     var mobile : String = ""
     var tel : String = ""
    var address : String = ""
    var services : [String] = []
    var pictures : [String] = []  // store links of pictures
    var userId : String = ""
    var minmumNumberOfClient:Int = 0
    
    init() {
        self.userId = ""
        self.storeId = ""
      self.storeName = ""
      self.discription = ""
      self.email = ""
      self.mobile = ""
      self.tel = ""
        self.address = ""
        self.services = []
        self.pictures = []
        self.minmumNumberOfClient = 0
    }
    
    ///  initilize data when programming
    init(storeId:String,storeName : String ,
         discription : String ,
         email : String ,
         mobile : String ,
         tel : String, address : String , services : [String],pictures : [String],userId : String,minmumNumberOfClient :Int) {
      self.storeName = storeName
      self.discription = discription
      self.email = email
      self.mobile = mobile
      self.tel = tel
        self.address = address
        self.services = services
        self.pictures = pictures
        self.storeId = storeId
        self.userId = userId
        self.minmumNumberOfClient = minmumNumberOfClient
    }
    
     /// to initalize data from firebase store
    init(value : NSDictionary) {
        self.userId = value["userId"] as! String
      self.storeName = value["storeName"] as! String
      self.discription = value["discription"] as! String
      self.email = value["email"] as! String
      self.mobile = value["mobile"] as! String
      self.tel = value["tel"] as! String
      self.address = value["address"] as! String
        self.minmumNumberOfClient = value["minmumNumberOfClient"] as! Int
        if(value["pictures"] != nil)
        {
            self.pictures = value["pictures"] as! [String]
        }
        if(value["services"] != nil)
        {
            self.services = value["services"] as! [String]
        }
        self.storeId = value["storeId"] as! String
    }
    
     /// to form data in json form to store in database
    func toDictionary() -> Any {
      return [
        "storeId" : self.storeId,
        "storeName" : self.storeName,
        "discription" : self.discription,
        "email" : self.email,
        "mobile" : self.mobile,
        "tel" : self.tel,
        "address" : self.address,
        "pictures" : self.pictures,
        "services":self.services,
        "userId" : self.userId,
        "minmumNumberOfClient" : self.minmumNumberOfClient
      ] as Any
    }
}
