//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//


import SwiftUI

// 메시지가 어디로 갈지, 어떻게 전달될지 결정하는데 필요한 모든 UI와 로직이 포함될 것임
struct ChatMessageCell: View {
    
    let message: Message
    // let isFromCurrentUser: Bool // 내가 작성한 메시지 인지 남이 작성한건지 파악하기 위한 변수
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        /*
         내가 작성한거면 HStack에 왼쪽에 Spacer를 줘서 오른쪽에서 보이게 남이 작성한거면 오른쪽에 Spacer를 줘서 왼쪽 부터 보이고 프로필 이미지와 함께 보이게 로직을 구현
         */
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                //Capsule() 말풍선을 Capsule로 깎는 거 대신 커스텀으로 만든 ChatBubble로 깎기
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                // 글이 길어지면 왼쪽으로 계속 넓어지는게 이쁘지 않음 적절한 설정
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xxSmall)
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    ChatMessageCell(isFromCurrentUser: false)
//}
