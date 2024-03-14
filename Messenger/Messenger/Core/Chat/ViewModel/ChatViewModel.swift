//
//  ChatViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/13/24.
//

import Foundation

class ChatViewModel: ObservableObject {   // classes require initializers

    @Published var messageText = ""
    @Published var messages = [Message]()
  
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }

    func sendMessage() {
        service.sendMessage(messageText)
    }

    // 메시지를 관찰하고 추가된 메시지는 관찰하여 해당 message 배열에 넣어주기
    func observeMessages() {
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
}
