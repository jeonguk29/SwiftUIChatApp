//
//  ChatView.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user //1. 초기화 될때마다 (다른 채팅하고 있는 사용자를 넣을 수 있음)
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        // 2. 각각의 사용자를 넣으면 해당 사용자와의 대화 내용을 감지하여 불러올 수 있음
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text(user.fullname)                      .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                
                // messages
                // 테스트 하기 유용 Bool.random()
                ForEach(viewModel.messages) { message in
                    ChatMessageCell(message: message)
                }
                
            }  //:SCROLL
            
            // message input view
            
            Spacer()
            // 하단 고정을 위해서는 스크롤뷰 범위를 빠져나와 Spacer를 적용받아야함
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48) // 전송 버튼과 간격을 위해
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button { // 바로 메시지를 전달 할 수 있음
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
