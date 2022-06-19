//
//  userTableviewCell.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import UIKit

class userTableviewCell: UITableViewCell {

    @IBOutlet weak var firstNameLable: UILabel!
    @IBOutlet weak var lastNameLable: UILabel!
    @IBOutlet weak var chatimageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatimageView.layer.cornerRadius = chatimageView.frame.width/2
        
    }


    
}
