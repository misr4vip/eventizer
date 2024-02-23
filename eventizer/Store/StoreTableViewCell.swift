
import UIKit

class StoreTableViewCell: UITableViewCell {

    var model = StoreModel()
    var cellProtocol : newCellDelegate?
    @IBOutlet weak var storeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func additionServiceTapped(_ sender: UIButton) {
        sender.tag = 103
        cellProtocol!.didPressButton(model,sender)
    }
    @IBAction func reservationTapped(_ sender: UIButton) {
        sender.tag = 102
        cellProtocol!.didPressButton(model,sender)
    }
    @IBAction func picBtn(_ sender: UIButton) {
        sender.tag = 100
        cellProtocol!.didPressButton(model,sender)
    }
    
    @IBAction func detailsBtn(_ sender: UIButton) {
        sender.tag = 101
        cellProtocol!.didPressButton(model,sender)
    }
}
