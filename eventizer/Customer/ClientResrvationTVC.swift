

import UIKit

class ClientResrvationTVC: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var resDateLbl: UILabel!
    @IBOutlet weak var storeNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
