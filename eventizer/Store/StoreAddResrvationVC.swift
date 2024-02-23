

import UIKit
import FirebaseDatabase
class StoreAddResrvationVC: UIViewController {
    var model : StoreModel?
    var strDate : String?
    @IBOutlet weak var pricetv: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(StoreAddResrvationVC.handler(sender:)), for: UIControl.Event.valueChanged)
      
    }
    
    @objc func handler(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        strDate = dateFormatter.string(from: datePicker.date)
        print(strDate as Any)
    }
   
    @IBAction func addResrvationTapped(_ sender: UIButton) {
        
        if pricetv.text!.isEmpty {
            return
        }
        let resId = UUID().uuidString
        let resModel = ResrvationModel(resId: resId, storeId: model!.storeId, clientId: "", resDate: self.strDate!, price: pricetv.text!, isResrved: false, isConfirmed: false)
        Database.database().reference().child(K.databaseRef.Resrvation).child(model!.storeId).child(resId).setValue(resModel.toDictionary()) { error, dataRef in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                K.getMsg(title: "Information", Msg: "Resrvation Added Successfully", context: self)
            }
            
        }
    }
    
}
