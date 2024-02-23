

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mySwitch: UISwitch!
    var userType = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
    }

    @IBAction func SignInbtn(_ sender: UIButton) {
        print("I'm Tapped")
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let signin = story.instantiateViewController(withIdentifier: K.Identifier.signInIdentifier) as? SignInViewController else{
            print("error in init")
            return
        }
        signin.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signin, animated: true)
        //self.present(signin, animated: true)
    }
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        let emailString = email.text!
        let passwordString = password.text!
        let nameString = name.text!
        let mobileString = mobile.text!
       
        /// validation first then register data to firebase auth and database
        if(mySwitch.isOn)
        {
            userType = K.databaseRef.storeUserType
        }else
        {
            userType = K.databaseRef.clientUserType
        }
        Auth.auth().createUser(withEmail: emailString, password: passwordString) { authResult, error in
            if(error == nil)
            {
                let userId = authResult?.user.uid
                let user = User(userId: userId!, name: nameString, email: emailString, mobile: mobileString, password: passwordString, userType: self.userType)
                Database.database().reference().child(K.databaseRef.users).child(userId!).setValue([user.toDictionary()]) { databaseError, databaseRef in
                    if(databaseError != nil)
                    {
                        print(databaseError!.localizedDescription)
                    }else
                    {
                        K.getMsg(title: "information", Msg: "Account Created Successfully" , context: self)
                    }
                }
                
            }else
            {
                print(error!.localizedDescription)
            }
        }
    }
    
    
}

