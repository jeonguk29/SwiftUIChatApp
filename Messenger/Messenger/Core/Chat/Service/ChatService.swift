//
//  ChatService.swift
//  Messenger
//
//  Created by 정정욱 on 3/14/24.
//


import Foundation
import Firebase

struct ChatService {

    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.messagesCollection.document(currentUid).collection(chatPartnerId ?? "").document()
        let chatPartnerRef = FirestoreConstants.messagesCollection.document(chatPartnerId ?? "").collection(currentUid)
        
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
    
    
    /// 특정 사용자와 관련된 모든 메시지를 가져오는 메서드
    /// - Parameters:
    ///   - chatPartner : 채팅목록을 가져올 사용자
    /// - Returns:채팅 목록을 반환
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.messagesCollection
            .document(currentUid) // 현재 사용자 아이디
            .collection(chatPartnerId ?? "") // 특정 사용자 아이디
            .order(by: "timestamp", descending: false) // 최근 메시지가 하단에 표시되게 조건주기
        // 이렇게하면 클라이언트 쪽에서 필터링 할 필요없이 서버쪽에서 필터링을 해서 보내줌
        
        // completion으로 한 이유가 addSnapshotListener(스냅샷 수신기)를 추가하여 실시간으로 관찰해 변경사항이 있으면 데이터를 가져오게 하기 위해서임
        query.addSnapshotListener { snapshot, _ in
            
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            // 컬렉션에 메시지가 추가될때마다 데이터를 가져오게 만드는 코드
            
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
