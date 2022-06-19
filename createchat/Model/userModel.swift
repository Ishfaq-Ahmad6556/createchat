//
//  userModel.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import Foundation

struct user: Equatable{

    var uid: String
    var firstname: String
    var lastname: String

    init(uid: String, firstname: String, lastname: String) {
       self.uid = uid
       self.firstname = firstname
       self.lastname = lastname
    }

}
