
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTV: UITextField!
    @IBOutlet weak var emailTV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
       
    }
    

   
    @IBAction func SignIn(_ sender: UIButton) {
        
        let emailString = emailTV.text!
        let passwordString = passwordTV.text!
        
        Auth.auth().signIn(withEmail: emailString, password: passwordString) {  result,error in
            if(error != nil)
            {
                print(error!.localizedDescription)
                K.getMsg(title: "Warrning!!", Msg: "Email or Password is incorrect", context: self)
                
            }else
            {
                Database.database().reference().child(K.databaseRef.users).child(result!.user.uid).getData { err, data in
                    if (err != nil)
                    {
                        print(err!.localizedDescription)
                        
                    }
                    
                    if let dataResult = data?.value as? NSDictionary,data!.exists() {
                      
                        let story = UIStoryboard(name: "Main", bundle: nil)
                        let user = User(value: dataResult)
                        if(user.userType.elementsEqual(K.databaseRef.clientUserType)){
                            
                            guard let clientResrvation = story.instantiateViewController(withIdentifier: "ClientResrvationVC") as? ClientResrvationVC else{
                                print("error in init")
                                return
                            }
                            guard let clientMain = story.instantiateViewController(withIdentifier: K.Identifier.clientMainIdentifier) as? ClientMainViewController else{
                                print("error in init")
                                return
                            }
                            guard let clientFav = story.instantiateViewController(withIdentifier: K.Identifier.clientMainIdentifier) as? ClientMainViewController else{
                                print("error in init")
                                return
                            }
                            guard let setting = story.instantiateViewController(withIdentifier: K.Identifier.SettingViewController) as? SettingViewController else{
                                print("error in init")
                                return
                            }
                            clientMain.isItsMain = true
                            clientFav.isItsMain = false
                            let tabBar = UITabBarController()
                           
                            
                            let tabSignOut = UITabBarItem(title: "setting", image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), selectedImage: UIImage(systemName: "rectangle.portrait.and.arrow.forward"))
                            let tabFav = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
                            clientFav.tabBarItem = tabFav
                            clientFav.title = "Favorite Stores"
                            setting.tabBarItem = tabSignOut
                            let tabOneBarItem = UITabBarItem(title: "Stores", image: UIImage(systemName: "rectangle.on.rectangle"), selectedImage: UIImage(systemName: "rectangle.on.rectangle"))
                            let tabTwoBarItem = UITabBarItem(title: "Resrvation", image: UIImage(systemName: "calendar.badge.clock"), selectedImage: UIImage(systemName: "calendar.badge.clock"))
                            clientResrvation.tabBarItem = tabTwoBarItem
                            clientMain.tabBarItem = tabOneBarItem
                            tabBar.viewControllers = [clientMain,clientResrvation,clientFav,setting]
                            let navi = UINavigationController(rootViewController: tabBar)
                            
                            navi.modalPresentationStyle = .fullScreen
                            self.present(navi, animated: true)
                            
                        }else{
                            guard let setting = story.instantiateViewController(withIdentifier: K.Identifier.SettingViewController) as? SettingViewController else{
                                print("error in init")
                                return
                            }
                            let tabBar = UITabBarController()
                           
                            let tabOneBarItem = UITabBarItem(title: "Stores", image: UIImage(systemName: "rectangle.on.rectangle"), selectedImage: UIImage(systemName: "rectangle.on.rectangle"))
                            let tabSignOut = UITabBarItem(title: "setting", image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"), selectedImage: UIImage(systemName: "rectangle.portrait.and.arrow.forward"))
                            guard let storeMain = story.instantiateViewController(withIdentifier: K.Identifier.storeMainIdentifier) as? StoreMainViewController else{
                                print("error in init")
                                return
                            }
                            storeMain.tabBarItem = tabOneBarItem
                            setting.tabBarItem = tabSignOut
                            tabBar.viewControllers = [storeMain,setting]
                            let navi = UINavigationController(rootViewController: tabBar)
                           
                            
                            navi.modalPresentationStyle = .fullScreen
                            self.present(navi, animated: true)
                        }
                    }
                }
                print("login successed")
            }
        }
    }
    @IBAction func SignUp(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let signup = story.instantiateViewController(withIdentifier: K.Identifier.signUpIdentifier) as? SignUpViewController else{
            return
        }
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signup, animated: true)
    }
}
