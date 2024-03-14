//
//  ChatViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/13/24.
//

import Foundation

class ChatViewModel: ObservableObject {   // classes require initializers

    @Published var messageText = ""
    let user: User

    init(user: User) {
        self.user = user
    }

    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }

}
