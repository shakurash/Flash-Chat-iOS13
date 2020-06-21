import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageBubleView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var someoneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubleView.layer.cornerRadius = messageBubleView.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
