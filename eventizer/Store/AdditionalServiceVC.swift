
import UIKit
import FirebaseDatabase
class AdditionalServiceVC: UIViewController {

    var additionalServices = [AdditionalServiceModel]()
    var mRef : DatabaseReference = Database.database().reference().child(K.databaseRef.AdditionalService)
    var storeId : String!
    var isDeleteBtnHidden : Bool!
    var isaddNewServiceHidden:Bool!
    @IBOutlet weak var addnewServiceBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addnewServiceBtn.isHidden = isaddNewServiceHidden
        tableView.register(UINib(nibName: "additionalServiceTVC", bundle: nil), forCellReuseIdentifier: "additionalServiceTVC")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        if( !self.additionalServices.isEmpty)
        {
            self.additionalServices.removeAll();
        }
        mRef.child(storeId!).getData { error, dataSnapShot in
            
            if(error == nil)
            {
                if(dataSnapShot!.exists()){
                    let data = dataSnapShot!.value as! NSDictionary
                    for (_, v) in data{
                        self.additionalServices.append(AdditionalServiceModel(value: v as! NSDictionary))
                    }
                    self.tableView.reloadData()
                }
            }else
            {
                print(error!.localizedDescription)
            }
        }
    }

    @IBAction func addServiceTapped(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let addService = story.instantiateViewController(withIdentifier: "AddAditionalService") as? AddAditionalService else{
              print("error in init view Controller")
              return
          }
        addService.storeId = storeId!
        addService.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addService, animated: true)
    }
    
}
extension AdditionalServiceVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.additionalServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "additionalServiceTVC", for: indexPath) as! additionalServiceTVC
        
        let model = self.additionalServices[indexPath.row]
        cell.serviceModel = model
        cell.cellDelegate = self
       // cell.serviceLinkLbl.text = model.additionalServiceLink
        cell.serviceNameLbl.text = model.additionalServiceName
        cell.isDeleteBtnHidden = self.isDeleteBtnHidden
        return cell
    }
    
    
    
}
extension AdditionalServiceVC : UITableViewDelegate,ServiceCellDelegate{
    func didPressButton(_ value: AdditionalServiceModel) {
        Database.database().reference().child(K.databaseRef.AdditionalService).child(storeId!).child(value.additionalServiceId).removeValue { error, dataRef in
            if(error != nil)
            {
                K.getMsg(title: "Error", Msg: error!.localizedDescription, context: self)
            }else{
                K.getMsg(title: "Information", Msg: "Service Remove Successfully", context: self)
            }
        }
    }
    
    
    
}
