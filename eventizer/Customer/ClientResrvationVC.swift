

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ClientResrvationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var resrvations = [ResrvationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My reservation"
        tableView.register(UINib(nibName: "ClientResrvationTVC", bundle: nil), forCellReuseIdentifier: "ClientResrvationTVC")
        tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    func getData()
    {
        if(!resrvations.isEmpty){resrvations.removeAll()}
        Database.database().reference().child(K.databaseRef.Resrvation).getData { error, dataShot in
            
            if error != nil
            {
                print(error!.localizedDescription)
            }else
            {
                guard let data = dataShot?.value as? NSDictionary, dataShot!.exists()  else
                {
                   print("error in data")
                    return
                }
                for(_ , val) in data
                {
                    for (_, v) in val as! NSDictionary
                    {
                        let value = v as? NSDictionary
                        let resModel = ResrvationModel(value: value!)
                        
                        if resModel.clientId == Auth.auth().currentUser!.uid
                        {
                            self.resrvations.append(resModel)
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func getStoreName(storeId : String) -> StoreModel{
        print("storeId : \(storeId)")
        var storeModel = StoreModel()
        Database.database().reference().child("Stores").getData { error, dataSnapShot in
            if((dataSnapShot?.exists()) != nil)
            {
                guard let data = dataSnapShot?.value  else{
                    print("error in getting stores data")
                    return
                }
                
                for (_ , value) in data as! NSDictionary{
                    
                    let value1 = value as! NSDictionary
                    for (k,v) in value1
                    {
                        let storeIdKey = k as! String
                        print("storeIdKey : \(storeIdKey)")
                        if(storeIdKey == storeId){
                            print("key Matching")
                            let modelValue = v as! NSDictionary
                             storeModel = StoreModel(value: modelValue)
                        }
                    }
                }
            }
        }
        return storeModel
    }
}
extension ClientResrvationVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resrvations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientResrvationTVC", for: indexPath) as? ClientResrvationTVC
        cell?.priceLbl.text = self.resrvations[indexPath.row].price
        cell?.resDateLbl.text  = self.resrvations[indexPath.row].resDate
        Database.database().reference().child("Stores").getData { error, dataSnapShot in
            if((dataSnapShot?.exists()) != nil)
            {
                guard let data = dataSnapShot?.value  else{
                    print("error in getting stores data")
                    return
                }
                for (_ , value) in data as! NSDictionary{
                    
                    let value1 = value as! NSDictionary
                    for (k,v) in value1
                    {
                        let storeIdKey = k as! String
                        print("storeIdKey : \(storeIdKey)")
                        if(storeIdKey == self.resrvations[indexPath.row].storeId){
                            print("key Matching")
                            let modelValue = v as! NSDictionary
                             let storeModel = StoreModel(value: modelValue)
                            cell?.storeNameLbl.text = storeModel.storeName
                        }
                    }
                }
            }
        }
       // cell?.storeNameLbl.text = getStoreName(storeId: self.resrvations[indexPath.row].storeId).storeName
        var status = ""
        if(self.resrvations[indexPath.row].isResrved && self.resrvations[indexPath.row].isConfirmed)
        {
            status = "Confirmed Resrvation"
        }else if(self.resrvations[indexPath.row].isResrved && !self.resrvations[indexPath.row].isConfirmed)
        {
            status = "Waiting for Confirm"
        }else if(!self.resrvations[indexPath.row].clientId.isEmpty && !self.resrvations[indexPath.row].isResrved && !self.resrvations[indexPath.row].isConfirmed)
        {
            status = "Refused Resrvation"
        }else
        {
            status = "UnStatus Resrvation"
        }
        cell?.statusLbl.text = status
        return cell!
    }
}
