//
//  ChatBubble.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI

// 말풍선 모양 커스텀 설정
struct ChatBubble: Shape {
    let isFromCurrentUser: Bool // 내가 작성한건지 상대방이 작성한건지 파악

    /*
     내가 작성한 메시지라면 클립을 상단 왼쪽, 오른쪽, 하단 왼쪽을 둥글게
     남이 작성한 메시자라면 클립을 상단 왼쪽, 오른쪽, 하단 오른쪽을 둥글게
     */
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topLeft,
                                    .topRight,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBubble(isFromCurrentUser: true)
}
