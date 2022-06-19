//
//  senderTbaleViewCell.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 18/03/2022.
//

import UIKit

class senderTbaleViewCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messageLable: UILabel!
    
    
    var chatobje = chatViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageView.layer.cornerRadius = 12
        //messageView.backgroundColor = UIColor(named: "E1F7CB")
        messageView.layer.cornerRadius = messageLable.frame.size.height / 2
        
        //contentView.backgroundColor = .clear
      //  backgroundColor = .clear
    }
    
    
    func configureCell(message: Message) {
        messageLable.text = message.message
      
    }

}
