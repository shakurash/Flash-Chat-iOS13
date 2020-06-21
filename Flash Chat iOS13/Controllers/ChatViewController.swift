import UIKit
import Firebase

class ChatViewController: UIViewController {

    var db = Firestore.firestore()
    var messages: [Messages] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = K.myAPP
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print(err)
            } else {
                self.messages = []
                if let retrievDataObject = querySnapshot?.documents {
                    for item in retrievDataObject {
                        if let messageSender = item.data()[K.FStore.senderField] as? String, let messageBody = item.data()[K.FStore.bodyField] as? String {
                            let msg = Messages(sender: messageSender, body: messageBody)
                            self.messages.append(msg)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let senderID = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.bodyField: messageBody, K.FStore.senderField: senderID, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let err = error {
                    print(err)
                } else {
                    DispatchQueue.main.async {
                            self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email {
            cell.avatarImageView.isHidden = false
            cell.someoneImageView.isHidden = true
            cell.messageBubleView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.avatarImageView.isHidden = true
            cell.someoneImageView.isHidden = false
            cell.messageBubleView.backgroundColor = UIColor(named: K.BrandColors.blue)
            cell.label.textColor = UIColor(named: K.BrandColors.lighBlue)
        }
        
        return cell
    }
}
