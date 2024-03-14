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
    let user: User

    init(user: User) {
        self.user = user
        observeMessages()
    }

    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }

    // 메시지를 관찰하고 추가된 메시지는 관찰하여 해당 message 배열에 넣어주기
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
        }
    }
}
