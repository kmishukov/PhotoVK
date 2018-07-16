//
//  Authorization.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 07.06.2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

struct Authorization {
    let access_token: String
    let user_id: String
    var expires_in: String
    
    init(access_token: String, user_id: String, expires_in: String ) {
        self.access_token = access_token
        self.user_id = user_id
        self.expires_in = expires_in
    }
}
