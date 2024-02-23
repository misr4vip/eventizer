

import UIKit
import FirebaseDatabase
class AddAditionalService: UIViewController {

    var storeId : String!
    @IBOutlet weak var serviceLinkTF: UITextField!
    @IBOutlet weak var serviceNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

  
    @IBAction func saveBtn(_ sender: Any) {
        if(serviceNameTF.text!.isEmpty || serviceLinkTF.text!.isEmpty){
            
            return
        }
        let additionalserviceId = UUID().uuidString
        let additionalService = AdditionalServiceModel(additionalServiceId: additionalserviceId, additionalServiceName: serviceNameTF.text!, additionalServiceLink: serviceLinkTF.text!)
        Database.database().reference().child(K.databaseRef.AdditionalService).child(storeId!).child(additionalserviceId).setValue(additionalService.toDictionary()) { error, dataShot in
                if(error != nil)
                {
                    print(error!.localizedDescription)
                }else{
                    
                    K.getMsg(title: "information", Msg: "Service Added Successfully", context: self)
                }
            }
    }
    
}
