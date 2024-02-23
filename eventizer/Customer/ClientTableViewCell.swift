
import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var minNumberOfClients: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var storeAddressLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model : StoreModel!
    var myDelegate : newCellDelegate!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favBtnTapped(_ sender: UIButton) {
        sender.tag = 102
        myDelegate.didPressButton(model, sender)
    }
    @IBAction func detailsBtn(_ sender: UIButton) {
        
        sender.tag = 100
        myDelegate.didPressButton(model, sender)
    }
    @IBAction func resrvationBtn(_ sender: UIButton) {
        sender.tag = 101
        myDelegate.didPressButton(model, sender)
    }
}
