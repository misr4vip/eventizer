

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ClientMainViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    var modles = [StoreModel]()
    var userId = ""
    var isItsMain = true
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stores"
        tableView.register(UINib(nibName: "ClientTableViewCell", bundle: nil), forCellReuseIdentifier: "ClientTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
         userId = Auth.auth().currentUser!.uid
       //title = "Main"
      
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        if(isItsMain)
        {
            self.modles.removeAll()
            self.tableView.reloadData()
            Database.database().reference().child(K.databaseRef.stores).getData { error, dataSnapShot in
                if error != nil{
                    print(error!.localizedDescription)
                }
                
                guard let data = dataSnapShot?.value as? NSDictionary , dataSnapShot!.exists() else{
                    print("error in init data")
                    return
                }
                
                for (_,v) in data  {
                    
                    for (_,value) in v as! NSDictionary{
                        
                        let myData = value as! NSDictionary
                        let model = StoreModel(value: myData)
                        self.modles.append(model)
                    }
                }
                self.tableView.reloadData()
            }
        }else
        {
            self.modles.removeAll()
            self.tableView.reloadData()
            let myRef = Database.database().reference().child("Fav").child(userId)
            myRef.getData { error, dataSnap in
                if(error != nil)
                {
                    print(error!.localizedDescription)
                }else
                {
                   
                    if dataSnap!.exists(){
                        
                        let data = dataSnap!.value as! NSDictionary
                        for (key , _) in data{
                            let storekey1 = key as! String
                            print("first \(storekey1)")
                            Database.database().reference().child(K.databaseRef.stores).getData { error1, dataSnapShot in
                                if error1 != nil{
                                    print(error1!.localizedDescription)
                                }
                                
                                guard let data1 = dataSnapShot?.value as? NSDictionary , dataSnapShot!.exists() else{
                                    print("error in init data")
                                    return
                                }
                                
                                for (_,v) in data1  {
                                    
                                    for (k,value) in v as! NSDictionary{
                                        let storeKey = k as! String
                                        print("second \(storeKey)")
                                        if storeKey == storekey1{
                                            let myData = value as! NSDictionary
                                            let model = StoreModel(value: myData)
                                            self.modles.append(model)
                                        }
                                       
                                    }
                                }
                               
                                self.tableView.reloadData()
                            }
                        }
                      
                    }
                }
            }
            
        }
       
    }

}
extension ClientMainViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.modles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var isFav = false
      
         let cell = tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCell", for: indexPath) as! ClientTableViewCell
        let model = self.modles[indexPath.row]
        cell.model = model
        cell.minNumberOfClients.numberOfLines = 2
        cell.minNumberOfClients.lineBreakMode = .byWordWrapping
        cell.minNumberOfClients.text = "minmum guest : \(model.minmumNumberOfClient)"
        cell.storeNameLbl.text = model.storeName
        cell.storeAddressLbl.text = model.address
        cell.storeImageView.downloaded(from: URL(string: model.pictures[0])!)
        cell.myDelegate = self
        Database.database().reference().child("Fav").child(userId).child(model.storeId).child(model.storeId).getData { error, dataSnap in
            if(dataSnap!.exists()){
                isFav = dataSnap?.value as! Bool
                if(isFav)
                {
                    cell.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }else{
                    cell.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }else{
                cell.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
          
        }
        return cell
    }
    
    
}
extension ClientMainViewController : UITableViewDelegate ,newCellDelegate{
    func didPressButton(_ model: StoreModel, _ Sender: UIButton) {
        let story  = UIStoryboard(name: "Main", bundle: nil)
        if Sender.tag == 100
        {
            let next = story.instantiateViewController(withIdentifier: "ClientStoreDetailsController") as? ClientStoreDetailsController
            next?.modalPresentationStyle = .fullScreen
            next?.model = model
            self.navigationController?.pushViewController(next!, animated: true)
        }else if Sender.tag == 101
        {
            let next = story.instantiateViewController(withIdentifier: K.Identifier.ClientStoreResrvationVc) as? ClientStoreResrvationVc
            next?.modalPresentationStyle = .fullScreen
            next?.model = model
            self.navigationController?.pushViewController(next!, animated: true)
        }else
        {
            var isFav = false
            let myRef = Database.database().reference().child("Fav").child(userId)
           myRef.child(model.storeId).child(model.storeId).getData { error, dataSnap in
                if(dataSnap!.exists()){
                    isFav = dataSnap?.value as! Bool
                    if(isFav)
                    {
                        myRef.child(model.storeId).removeValue()
                        if(!self.isItsMain)
                        {
                            self.getData()
                        }
                        self.tableView.reloadData()
                    }else{
                        myRef.child(model.storeId).setValue([model.storeId : true])
                        self.tableView.reloadData()
                    }
                }else
               {
                    myRef.child(model.storeId).setValue([model.storeId : true])
                    self.tableView.reloadData()
                }
              
            }
        }
    }
}
