
import UIKit
import FirebaseDatabase
class StoreDetailsViewController: UIViewController {

    @IBOutlet weak var minNumberOFClients: UITextField!
    @IBOutlet weak var storeServices: UITextField!
    @IBOutlet weak var storeAddress: UITextField!
    @IBOutlet weak var storeTel: UITextField!
    @IBOutlet weak var storeMobile: UITextField!
    @IBOutlet weak var storeEmail: UITextField!
    @IBOutlet weak var storeDisc: UITextField!
    @IBOutlet weak var storeName: UITextField!
    var model : StoreModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update store"

       loadData()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let servicesString = storeServices.text
        var servicesArray = [String]()
        let servicesSubString : [Substring] =  (servicesString?.split(separator: ",", omittingEmptySubsequences: true))!
        for x in servicesSubString
        {
            print(String(x))
            servicesArray.append(String(x))
        }
        model.storeName = storeName.text!
        model.discription = storeDisc.text!
        model.email = storeEmail.text!
        model.mobile = storeMobile.text!
        model.tel = storeTel.text!
        model.address = storeAddress.text!
        model.minmumNumberOfClient = Int(minNumberOFClients.text!)!
        model.services = servicesArray
        Database.database().reference().child(K.databaseRef.stores).child(model.userId).child(model.storeId).setValue(model.toDictionary()) { error, ref in
            if(error != nil)
            {
                print(error!.localizedDescription)
            }else
            {
                K.getMsg(title: "info", Msg: "Store Updated Successfully", context: self)
            }
        }
    }
    
    func loadData()
    {
        if(model != nil)
        {
            storeName.text = model.storeName
            storeDisc.text = model.discription
            storeEmail.text = model.email
            storeMobile.text = model.mobile
            storeTel.text = model.tel
            storeAddress.text = model.address
            minNumberOFClients.text = String(model.minmumNumberOfClient)
            var txt = ""
            for x in model.services
            {
                if(x == model.services.first){
                    
                    txt += x
                }else
                {
                    txt += ",\(x)"
                }
            }
            storeServices.text = txt
        }
       
        
    }
}
