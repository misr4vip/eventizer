
import UIKit
import FirebaseDatabase
class ResrvationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMobileLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var confirmedForLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    var model : ResrvationModel!
    var mycellDelgate : ResrvationCellDelegate!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        
        mycellDelgate.didPressButton(model, sender,100)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
       
        mycellDelgate.didPressButton(model, sender,101)
    }
}
