
import UIKit

struct K {

 
    struct Identifier
    {
        static let  signInIdentifier = "SignIn"
        static let signUpIdentifier = "SignUp"
        static let clientMainIdentifier = "ClientMain"
        static let storeMainIdentifier = "StoreMain"
        static let addStoreIdentifier = "AddStore"
        static let StoreTabelCell = "StoreTableViewCell"
        static let StorePicture = "StorePicture"
        static let StoreDetails = "StoreDetails"
        static let storeAddPicture = "storeAddPicture"
        static let StoreReservation = "StoreReservation"
        static let addResrvationVc = "addResrvationVc"
        static let ClientStoreResrvationVc = "ClientStoreResrvationVc"
        static let resrvationTVC = "resrvationTVC"
        static let SettingViewController = "SettingViewController"
        static let ClientResrvationVC = "ClientResrvationVC"
        
    }
  
    struct databaseRef
    {
       
        static let clientUserType = "Client"
        static let storeUserType = "Store"
        static let users = "users"
        static let stores = "Stores"
        static let Resrvation = "Resrvation"
        static let AdditionalService = "AdditionalService"
    }
  
    static func getMsg(title: String,
                       Msg: String,
                       context: UIViewController)
    {
      let alert = UIAlertController(title: title,
                                      message: Msg,
                                      preferredStyle: .alert)
      
      let dismiss = UIAlertAction(title: "Dismiss",
                                  style: .cancel)
      {  DismissAction in
            
        print("Dismiss Done")
          
        }
       
        alert.addAction(dismiss)
      
        context.present(alert, animated: true) {
           
          print("Alert Start")
        }
    }
  
    
    typealias handler = (_ result : String,
                         _ error :Bool)-> Void
        
  static func getMsg(title: String,
                     Msg: String,
                     context: UIViewController,
                     callBack:@escaping handler) {
    
            var action = ""
            let alert = UIAlertController(title: title,
                                          message: Msg,
                                          preferredStyle: .alert)
    
            let dismiss = UIAlertAction(title: "Dismiss",
                                        style: .cancel)
            {  DismissAction in
                
                action = "Dismiss"
                print(action)
                callBack(action,false)
            }
      let ok = UIAlertAction(title: "ok",
                             style: .default)
      {  okAction in
          
          action = "ok"
          print(action)
          callBack(action,false)
      }
            alert.addAction(dismiss)
            alert.addAction(ok)
            context.present(alert, animated: true) {
              print("Alert Start")
            }
        }
  
  
 
  
}



