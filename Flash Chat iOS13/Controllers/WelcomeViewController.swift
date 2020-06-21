import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.myAPP
        
//        var tick = 0.0
//        let title = "⚡️FlashChat"
//        titleLabel.text = ""
//        for letter in title{
//            Timer.scheduledTimer(withTimeInterval: 0.2 * tick, repeats: false) { (animationTime) in
//                self.titleLabel.text?.append(letter)
//            }
//            tick += 1
//        }
//
        
    }
    

}
