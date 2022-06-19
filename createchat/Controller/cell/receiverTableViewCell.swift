//
//  receiverTableViewCell.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 18/03/2022.
//

import UIKit

class receiverTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLeftView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageLeftView.layer.cornerRadius = 12
        messageLeftView.backgroundColor = .white
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    func configureCell(message: Message) {
        messageLabel.text = message.message
    }
    
    
    
}
