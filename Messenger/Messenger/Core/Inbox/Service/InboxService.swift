//
//  InboxService.swift
//  Messenger
//
//  Created by 정정욱 on 3/14/24.
//

import Foundation
import Firebase

// 최근 대화한 메시지들을 가져오기 위함
class InboxService {
    @Published var documentChanges = [DocumentChange]()

    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let query = FirestoreConstants
            .messagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        // 기존건 처음에 다 가져오고 이후 추가된거, 수정된건 바로 반영시키기
        // 즉 처음 사용자가 다른 사용자와 나눈 최근 메시지들을 모두 가져오고 그다음 추가, 수정된거를 반영
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            self.documentChanges = changes
        }
    }

}
