//
//  User.swift
//  Journal
//
//  Created by Jonah May on 12/4/16.
//  Copyright © 2016 Your School. All rights reserved.
//

import Foundation
import Firebase
class User {
    var uid: String
    var email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }

}
