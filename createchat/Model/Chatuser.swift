//
//  Chatuser.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 28/03/2022.
//

import Foundation
import UIKit

struct ChatUser: Equatable {
   
var senderId: String
var displayName: String
    
    internal init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
