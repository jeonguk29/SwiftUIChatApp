//
//  Constants.swift
//  Messenger
//
//  Created by 정정욱 on 3/14/24.
//

import Foundation
import Firebase

struct FirestoreConstants {

    static let usersCollection = Firestore.firestore().collection("users")
    static let messagesCollection = Firestore.firestore().collection("messages")
}
