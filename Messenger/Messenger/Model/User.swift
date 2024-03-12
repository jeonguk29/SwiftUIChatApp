//
//  User.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var id: String? // 도큐먼트 식별자를 해당 속성에 자동으로 할당하는 방법
    // Identifiable를 채택해서 id속성은 있어야함 
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    
    
}

extension User {
    // 임시 사용자
    static let MOCK_USER = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}

