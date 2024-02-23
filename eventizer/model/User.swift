
import Foundation

struct User
{
    
     var userId : String
     var name : String
     var email : String
     var mobile : String
     var password : String
     var userType : String
    
   
    init() {
      self.userId = ""
      self.name = ""
      self.email = ""
      self.mobile = ""
      self.password = ""
        self.userType = ""
    }
    
    
    init(userId : String ,
         name : String ,
         email : String ,
         mobile : String ,
         password : String, userType : String) {
      self.userId = userId
      self.name = name
      self.email = email
      self.mobile = mobile
      self.password = password
        self.userType = userType
    }
    
    
    init(value : NSDictionary) {
      self.userId = value["userId"] as! String
      self.name = value["name"] as! String
      self.email = value["email"] as! String
      self.mobile = value["mobile"] as! String
      self.password = value["password"] as! String
        self.userType = value["userType"] as! String
    }
    
    
    func toDictionary() -> Any {
      return [
        "userId" : self.userId,
        "name" : self.name,
        "email" : self.email,
        "mobile" : self.mobile,
        "password" : self.password,
        "userType" : self.userType
      ] as Any
    }
}




