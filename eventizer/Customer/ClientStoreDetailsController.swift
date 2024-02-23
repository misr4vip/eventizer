
import UIKit



class ClientStoreDetailsController: UIViewController {
    var model = StoreModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var storeEmail: UILabel!
    @IBOutlet weak var storeTel: UILabel!
    @IBOutlet weak var storeMobile: UILabel!
    @IBOutlet weak var storeAddressLbl: UILabel!
    @IBOutlet weak var storeServices: UILabel!
    @IBOutlet weak var storeDiscLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store page"
        
        collectionView.register(UINib(nibName: "ClientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClientCollectionViewCell")
        collectionView.dataSource = self
        
            
            storeNameLbl.text = model.storeName
            storeAddressLbl.text = model.address
            storeDiscLbl.text = model.discription
            storeMobile.text = model.mobile
            storeTel.text = model.tel
            storeEmail.text = model.email
            var text : String = ""
            for x in model.services {
                text += x
            }
            storeServices.text = text
        storeDiscLbl.numberOfLines = 4
        storeDiscLbl.clipsToBounds = false
        storeDiscLbl.lineBreakMode = .byWordWrapping
        
    }
    
    @IBAction func whatsappTapped(_ sender: Any) {
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(model.mobile)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    @IBAction func outSourceService(_ sender: UIButton) {
        
        guard let StoreAdditionalService = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdditionalServiceVC") as? AdditionalServiceVC else{
      
      print("error in init view Controller")
      return
  }
        StoreAdditionalService.isaddNewServiceHidden = true
        StoreAdditionalService.isDeleteBtnHidden = true
        StoreAdditionalService.storeId = model.storeId
        StoreAdditionalService.modalPresentationStyle = .fullScreen
  self.navigationController?.pushViewController(StoreAdditionalService, animated: true)

    }
}

extension ClientStoreDetailsController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.pictures.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClientCollectionViewCell", for: indexPath) as! ClientCollectionViewCell
        cell.collectionImageView.downloaded(from: URL(string: self.model.pictures[indexPath.row])!)
        return cell
        
    }
    
    
}
