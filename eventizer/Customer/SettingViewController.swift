

import UIKit
import FirebaseAuth
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: UIButton) {
        do{
            print("tapped")
            try Auth.auth().signOut()
            let story = UIStoryboard(name: "Main", bundle: nil)
            guard let signin = story.instantiateViewController(withIdentifier: K.Identifier.signInIdentifier) as? SignInViewController else{
                return
            }
            signin.navigationItem.setHidesBackButton(true, animated: true)
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(signin, animated: true)
        }catch
        {
            print(error.localizedDescription)
        }

    }
    
    
}


