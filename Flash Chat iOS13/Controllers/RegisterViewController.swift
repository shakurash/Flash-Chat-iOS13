import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = K.myAPP
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let password = passwordTextfield.text, let email = emailTextfield.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
        }
    }
    
}
