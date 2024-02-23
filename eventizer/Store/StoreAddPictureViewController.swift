
import UIKit
import FirebaseStorage
 import FirebaseDatabase

class StoreAddPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var model = StoreModel()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
       // navigationItem.hidesBackButton = true
        
    }
    
    
    @IBAction func chosePhotoTapped(_ sender: Any) {
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self // new
        present(imagePickerVC, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            self.indicator.isHidden = false
            self.indicator.sizeThatFits(CGSize(width: 150.0, height: 150.0))
            var data = NSData()
            data = image.jpegData(compressionQuality: 0.8)! as NSData
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            let id = UUID().uuidString
            let imageRef =   Storage.storage().reference().child("Images/\(id).jpg")
            
            imageRef.putData( data as Data, metadata: metaData) { metadata, error in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    imageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            return
                        }
                        self.model.pictures.append(downloadURL.absoluteString)
                        Database.database().reference().child(K.databaseRef.stores).child(self.model.userId).child(self.model.storeId).setValue(self.model.toDictionary()) { error, dataRef in
                            if let error = error{
                                print(error.localizedDescription)
                                K.getMsg(title: "information", Msg: error.localizedDescription, context: self)
                            }else
                            {
                                print("image uploaded Successfully")
                               
                                self.indicator.isHidden = true
                                K.getMsg(title: "information", Msg: "image uploaded Successfully", context: self) { result, error in
                                    self.navigationController?.popToRootViewController(animated: true)
                                    //self.navigationItem.hidesBackButton = false
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
}
