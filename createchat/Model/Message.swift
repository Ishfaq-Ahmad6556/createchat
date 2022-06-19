//
//  Message.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 20/03/2022.
//

import Foundation
import Firebase


struct Message {

 
    var Timestamp: Timestamp
   // var id: String
    var message: String
    var senderID: String
    var senderName: String
    
//id: String,
    internal init(Timestamp: Timestamp,  message: String, senderID: String, senderName: String) {
      //  self.id = id
        self.message = message
        self.senderID = senderID
        self.senderName = senderName
        self.Timestamp = Timestamp
    }


}


// MARK: for left right cell use

//enum MessageSide {
//    case left
//    case right
//}



//  var text = ""
 // var side: MessageSide = .right
