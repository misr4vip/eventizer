

import Foundation
import UIKit
protocol MyCellDelegate: AnyObject {
  
    func didPressButton(_ tag: Int)
}
protocol StringCellDelegate: AnyObject {
  
    func didPressButton(_ value: String)
}
protocol ServiceCellDelegate: AnyObject {
  
    func didPressButton(_ value: AdditionalServiceModel)
}
protocol newCellDelegate: AnyObject {
  
    func didPressButton(_ model: StoreModel, _ Sender : UIButton)
}

protocol ResrvationCellDelegate: AnyObject {
  
    func didPressButton(_ model: ResrvationModel, _ Sender : UIButton,_ tag:Int)
}
