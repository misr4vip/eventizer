
import UIKit

class additionalServiceTVC: UITableViewCell {
    var isDeleteBtnHidden : Bool!
    var serviceModel : AdditionalServiceModel!
    var cellDelegate : ServiceCellDelegate!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
 
   
    @IBOutlet weak var serviceNameLbl: UILabel!
    
    @IBOutlet weak var serviceLinkButton: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        deleteBtn.isHidden = isDeleteBtnHidden
        
        // Configure the view for the selected state
    }
    
    @IBAction func linkTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: serviceModel.additionalServiceLink)!)
    }
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        cellDelegate.didPressButton(serviceModel)
    }
}
