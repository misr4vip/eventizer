
import UIKit
import FirebaseDatabase
import FirebaseAuth
class StoreMainViewController: UIViewController {
    var modles = [StoreModel]()
    var userId = ""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Stores"
        userId = Auth.auth().currentUser!.uid
        
        tableView.register(UINib(nibName: K.Identifier.StoreTabelCell, bundle: nil), forCellReuseIdentifier: K.Identifier.StoreTabelCell)
        tableView.dataSource = self
        tableView.delegate = self
        fillModelData()
    }
    
    func fillModelData()
    {
        Database.database().reference().child(K.databaseRef.stores).child(userId).getData { error, data in
            if(data != nil)
            {
                guard let storesData = data!.value as? NSDictionary else
                {
                    print("error in data")
                    return
                }
                if (self.modles.count > 0)
                {
                    self.modles.removeAll()
                }
                for (_,v) in storesData
                {
                    let value = v as! NSDictionary
                    let model = StoreModel.init(value: value)
                    self.modles.append(model)
                }
                self.tableView.reloadData()
                
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillModelData()
    }
    @IBAction func addStoreTapped(_ sender: Any) {
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let addStore = story.instantiateViewController(withIdentifier: K.Identifier.addStoreIdentifier) as? AddStoreViewController else{
            print("error in init ")
            return
        }
        addStore.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addStore, animated: true)
    }
    

}
extension StoreMainViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifier.StoreTabelCell, for: indexPath) as? StoreTableViewCell else
        {
            print("error in init cell")
            return UITableViewCell()
        }
        cell.cellProtocol = self
        cell.model = self.modles[indexPath.row]
        cell.storeNameLabel.text = self.modles[indexPath.row].storeName
        return cell
    }
    
    
    
}
extension StoreMainViewController : UITableViewDelegate,newCellDelegate{
    
    func didPressButton(_ model: StoreModel, _ Sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        if(Sender.tag == 100)
        {
            // navigate to pictures
           
            guard let PictureView = story.instantiateViewController(withIdentifier: K.Identifier.StorePicture) as? StorePicturesViewController else{
                
                print("error in init view Controller")
                return
            }
            PictureView.model = model
            PictureView.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(PictureView, animated: true)
            
        }else if(Sender.tag == 101)
        {
            ///  navigate to details
              guard let StoreDetails = story.instantiateViewController(withIdentifier: K.Identifier.StoreDetails) as? StoreDetailsViewController else{
            
            print("error in init view Controller")
            return
        }
            StoreDetails.model = model
            StoreDetails.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(StoreDetails, animated: true)
        }else if(Sender.tag == 102)
        {
            ///  navigate to details
              guard let StoreResrvation = story.instantiateViewController(withIdentifier: K.Identifier.StoreReservation) as? StoreReservationViewController else{
            
            print("error in init view Controller")
            return
        }
            StoreResrvation.model = model
            StoreResrvation.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(StoreResrvation, animated: true)
        }else
        {
            guard let StoreAdditionalService = story.instantiateViewController(withIdentifier: "AdditionalServiceVC") as? AdditionalServiceVC else{
          
          print("error in init view Controller")
          return
      }
            StoreAdditionalService.isaddNewServiceHidden = false
            StoreAdditionalService.isDeleteBtnHidden = false
            StoreAdditionalService.storeId = model.storeId
            StoreAdditionalService.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(StoreAdditionalService, animated: true)

        }
    }
    
    
    
    
    
    
}
