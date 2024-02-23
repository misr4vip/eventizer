
import UIKit
import FirebaseDatabase
class ClientStoreResrvationVc: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model : StoreModel!
    var resrvations = [ResrvationModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reservation"
        
        tableView.register(UINib(nibName: K.Identifier.resrvationTVC, bundle: nil), forCellReuseIdentifier: K.Identifier.resrvationTVC)
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    func getData()
    {
        Database.database().reference().child(K.databaseRef.Resrvation).child(model.storeId).getData { error, dataShot in
            
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
                
                for (_, v) in data
                {
                    let value = v as? NSDictionary
                    let resModel = ResrvationModel(value: value!)
                    if !resModel.isConfirmed 
                    {
                        self.resrvations.append(resModel)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

}

extension ClientStoreResrvationVc : UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resrvations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifier.resrvationTVC, for: indexPath) as? resrvationTVC
        if self.resrvations[indexPath.row].isResrved == true
        {
            cell?.resBtn.isEnabled = false
            cell?.accessoryType = .checkmark
        }
        cell?.dateLbl.text = self.resrvations[indexPath.row].resDate
        cell?.priceLbl.text = "\(self.resrvations[indexPath.row].price) SR"
        cell?.model = self.resrvations[indexPath.row]
        cell?.parent = self
        return cell!
    }
    
    
    
}
