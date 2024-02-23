
import UIKit
import FirebaseDatabase
import FirebaseAuth

class StoreReservationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model : StoreModel!
    var myRef : DatabaseReference = Database.database().reference()
    var resrvations = [ResrvationModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ResrvationTableViewCell", bundle: nil), forCellReuseIdentifier: "ResrvationTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
   
    func getData(){
        print("try to get data")
        self.myRef.child(K.databaseRef.Resrvation).child(model.storeId).getData { error, dataSnapShot in
            
            if(error != nil)
            {
                print(error!.localizedDescription)
            }else
            {
                if dataSnapShot!.exists(){
                    if !self.resrvations.isEmpty{
                        self.resrvations.removeAll()
                    }
                    for (_,v) in dataSnapShot?.value as! NSDictionary {
                        let value = v as! NSDictionary
                        let resrvation  = ResrvationModel(value: value )
                        self.resrvations.append(resrvation)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func addNewResrvation(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let addResrvation = story.instantiateViewController(withIdentifier: K.Identifier.addResrvationVc) as? StoreAddResrvationVC else{
              print("error in init view Controller")
              return
          }
        addResrvation.model = model
        addResrvation.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addResrvation, animated: true)
    }
    
}

extension StoreReservationViewController : UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resrvations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResrvationTableViewCell", for: indexPath) as! ResrvationTableViewCell
        cell.dateLabel.text = resrvations[indexPath.row].resDate
        cell.priceLabel.text = resrvations[indexPath.row].price
        
        cell.model = resrvations[indexPath.row]
        cell.mycellDelgate = self
        var status = ""
        if(resrvations[indexPath.row].isResrved && resrvations[indexPath.row].isConfirmed)
        {
            status = "Confirmed"
            cell.confirmBtn.isHidden = true
            cell.cancelBtn.isHidden = true
        }else if(resrvations[indexPath.row].isResrved && !resrvations[indexPath.row].isConfirmed){
            
            status = "Resrvaed"
            cell.confirmBtn.isHidden = false
            cell.cancelBtn.isHidden = false
        }else
        {
            status = "avilable"
            cell.confirmBtn.isHidden = true
            cell.cancelBtn.isHidden = true
        }
        if(status == "Confirmed" || status == "Resrvaed"){
           
            let userId = self.resrvations[indexPath.row].clientId
            
            self.myRef.child(K.databaseRef.users).child(userId).getData { userError, userData  in
                 if(userError != nil)
                 {
                     print(userError!.localizedDescription)
                 }else
                 {
                     let data = userData!.value as! NSDictionary
                     let user = User(value: data)
                     cell.userLbl.text = user.name
                     cell.mobileLbl.text = user.mobile
                     cell.userLbl.isHidden = false
                     cell.confirmedForLbl.isHidden = false
                     cell.mobileLbl.isHidden = false
                     cell.lblMobileLbl.isHidden = false
                 }
             }
        }else
        {
            cell.userLbl.isHidden = true
            cell.confirmedForLbl.isHidden = true
            cell.mobileLbl.isHidden = true
            cell.lblMobileLbl.isHidden = true
        }
      
       
        cell.statusLbl.text = status
        return cell
    }
    
    
}
extension StoreReservationViewController : UITableViewDelegate ,ResrvationCellDelegate
{
    func didPressButton(_ model: ResrvationModel, _ Sender: UIButton,_ tag : Int) {
      
        if(tag == 100)
        {
            Database.database().reference().child(K.databaseRef.Resrvation).child(model.storeId).child(model.resId).updateChildValues(["isConfirmed" : true]) { error, dataSnap in
                if(error != nil)
                {
                    K.getMsg(title: "error", Msg: "error in confirm Resrvation", context: self)
                }
            }
        }else
        {
            Database.database().reference().child(K.databaseRef.Resrvation).child(model.storeId).child(model.resId).updateChildValues(["isResrved" : false,"isConfirmed" : false]) { error, dataSnap in
                if(error != nil)
                {
                    K.getMsg(title: "error", Msg: "error in cancel Resrvation", context: self)
                }else{
                    var x = 0
                    for m in self.resrvations {
                        if (model.resId == m.resId)
                        {
                            break;
                        }
                      x += 1
                    }
                    self.resrvations[x].isResrved = false;
                    self.resrvations[x].isConfirmed = false;
                    self.tableView.reloadData()
                }
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action: UIContextualAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            Database.database().reference().child(K.databaseRef.Resrvation).child(self.model.storeId).child(self.resrvations[indexPath.row].resId).removeValue { error, ref in
                if(error != nil)
                {
                    print(error!.localizedDescription)
                }else
                {
                    self.resrvations.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
                    self.tableView.reloadData()
                }
            }
                    completionHandler(true)
                }
                action.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white, renderingMode: .alwaysOriginal)
                action.backgroundColor = UIColor.red
                return UISwipeActionsConfiguration(actions: [action])
    }
    
}
