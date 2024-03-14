//
//  Message.swift
//  Messenger
//
//  Created by 정정욱 on 3/13/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String // 누구에게 온 메시지인지
    let toId: String // 누구에게 가는 메시지인지
    let messageText: String
    let timestamp: Timestamp // 메시지가 전송된 시간

    var user: User?

    var id: String {
        return messageId ?? NSUUID().uuidString
    }

    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    } // 누구와 채팅하고 있는지 파악하기 위해

    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    } // 메시지를 왼쪽(남이 작성), 오른쪽(내가 작성)에 배치할지 파악하기 위한 변수
}
