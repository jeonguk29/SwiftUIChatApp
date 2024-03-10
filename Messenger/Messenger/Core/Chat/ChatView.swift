//
//  ChatView.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""

    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xLarge)

                    VStack(spacing: 4) {
                        Text("Bruce Wayne")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }

                // messages
                // 테스트 하기 유용 Bool.random()
                ForEach(0...15, id: \.self) { message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
                    
            }  //:SCROLL

            // message input view

            Spacer()
            // 하단 고정을 위해서는 스크롤뷰 범위를 빠져나와 Spacer를 적용받아야함 
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48) // 전송 버튼과 간격을 위해
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)

                Button {
                    print("Send message")
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
    ChatView()
}
