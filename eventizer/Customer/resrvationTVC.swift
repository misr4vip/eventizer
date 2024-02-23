

import UIKit
import FirebaseDatabase
import FirebaseAuth
class resrvationTVC: UITableViewCell {

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var resBtn: UIButton!
    var model : ResrvationModel!
    var parent : UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func resrvationBtn(_ sender: UIButton) {
        let clientId = Auth.auth().currentUser?.uid
        model.clientId = clientId!
        model.isResrved = true
        Database.database().reference().child(K.databaseRef.Resrvation).child(model.storeId).child(model.resId).setValue(model.toDictionary()) { error, dataRef in
            
            if error != nil
            {
                K.getMsg(title: "error!", Msg: error!.localizedDescription, context: self.parent )
            }else{
                K.getMsg(title: "Information", Msg: "Request send to Store Successfully", context: self.parent )
                sender.isHidden = true

            }
            
        }
    }
}
