//
//  MessageService.swift
//  Messenger
//
//  Created by 정정욱 on 3/13/24.
//

import Foundation
import Firebase

struct MessageService {

    static let messagesCollection = Firestore.firestore().collection("messages")

    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id

        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId ?? "").document()
        let chatPartnerRef = messagesCollection.document(chatPartnerId ?? "").collection(currentUid)

        let messageId = currentUserRef.documentID

        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId ?? "",
            messageText: messageText,
            timestamp: Timestamp()
        )

        guard let messageData = try? Firestore.Encoder().encode(message) else { return }

        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
    
    /* 두 사용자 간에 동일한 메시지 ID를 공유하고 있음 이렇게 해야 채팅이 두사람 모두에게 표시됨
        내 최근 메시지와 상대방 측에 표시해야 하는 항목에 표시하려면 필요하기 때문임
     */
}
