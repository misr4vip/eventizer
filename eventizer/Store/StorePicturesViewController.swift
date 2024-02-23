
import UIKit
import FirebaseDatabase
import FirebaseStorage
class StorePicturesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var model = StoreModel()
    var imageRef : StorageReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageRef = Storage.storage().reference().child("Images")
       collectionView.register(UINib(nibName: "StorePicturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StorePicturesCollectionViewCell")
       // collectionView.register(StorePicturesCollectionViewCell.self, forCellWithReuseIdentifier: "StorePicturesCollectionViewCell")
         
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func addNewPhotoTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let addPhoto = story.instantiateViewController(withIdentifier: K.Identifier.storeAddPicture) as? StoreAddPictureViewController else{
            print("error in init ")
            return
        }
        addPhoto.model = model
        addPhoto.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addPhoto, animated: true)
    }
    
}

extension StorePicturesViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        K.getMsg(title: "Delete Item", Msg: "did you want to delete this picture?", context: self, callBack: { result,error in
            if(result.elementsEqual("ok")){
                collectionView.deleteItems(at: [indexPath])
                self.model.pictures.remove(at: indexPath.row)
                Database.database().reference().child(K.databaseRef.stores).child(self.model.userId).child(self.model.storeId).removeValue()
                Database.database().reference().child(K.databaseRef.stores).child(self.model.userId).child(self.model.storeId).setValue(self.model.toDictionary()) { error, dataRef in
                    if(error != nil)
                    {
                        print(error!.localizedDescription)
                    }
                }
                collectionView.reloadData()
            }
        })
    }
}

extension StorePicturesViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of images : \(self.model.pictures.count)")
        return self.model.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StorePicturesCollectionViewCell", for: indexPath) as? StorePicturesCollectionViewCell else {
            print("erorr in creating Cell")
            return UICollectionViewCell()
            
        }
        let localURL = URL(string: self.model.pictures[indexPath.row])!
        print("local url = \(localURL)")
        cell.myImageView.downloaded(from: localURL)
        return cell
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            print("data of image \(data)")
            DispatchQueue.main.async() { [weak self] in
                print("image hok to image view")
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


