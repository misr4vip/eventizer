
import UIKit
import FirebaseDatabase
import FirebaseAuth
class AddStoreViewController: UIViewController {

    @IBOutlet weak var minNumberOfClients: UITextField!
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var discr: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var services: UITextField!
    @IBOutlet weak var email: UITextField!
    var userId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Store"
        minNumberOfClients.keyboardType = .numberPad
        if(Auth.auth().currentUser != nil)
        {
            userId = Auth.auth().currentUser!.uid
        }
    }
    @IBAction func saveTapped(_ sender: Any) {
         // check if text field is empty or not
        if(Utilities.isEmptyTextField(txt: storeName) || Utilities.isEmptyTextField(txt: mobile) || Utilities.isEmptyTextField(txt: tel) || Utilities.isEmptyTextField(txt: services) || Utilities.isEmptyTextField(txt: address) ||
           Utilities.isEmptyTextField(txt: minNumberOfClients) ||
           userId.isEmpty){return}
        print("validation end")
        let id = UUID().uuidString
        let servicesString = services.text
        var servicesArray = [String]()
        let servicesSubString : [Substring] =  (servicesString?.split(separator: ",", omittingEmptySubsequences: true))!
        for x in servicesSubString
        {
            print(String(x))
            servicesArray.append(String(x))
        }
        
        let min : Int = Int(minNumberOfClients.text!)!
        let model = StoreModel(storeId: id, storeName: storeName.text!, discription: discr.text!, email: email.text!, mobile: mobile.text!, tel: tel.text!, address: address.text!, services: servicesArray, pictures: [],userId: userId,minmumNumberOfClient: min)
        Database.database().reference().child(K.databaseRef.stores).child(userId).child(model.storeId).setValue(model.toDictionary()) { error, ref in
            if(error != nil)
            {
                print(error!.localizedDescription)
            }else
            {
                K.getMsg(title: "info", Msg: "Store Added Successfully", context: self)
            }
        }
    }
    
}
