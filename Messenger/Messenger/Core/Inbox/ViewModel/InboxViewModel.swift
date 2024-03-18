//
//  InboxViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/12/24.
//

import Foundation
import Combine
import Firebase


class InboxViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    // 로그인된 사용자를 감시하여 변경일어나면 알맞게 대화중인 메시지 및 프로필 뷰를 보여줄 것임
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        // 변경이 일어나면 문서를 전달
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        // 메시지 배열을 생성 결국 이시점이 실제로 UI가 업데이트 되는 시점임
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            // 메시지만 보여줄수 없기 때문에 메시지 chatPartnerId 값으로 사용자를 반환하여 넣기
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
    
   
    
}
