//
//  Route.swift
//  Messenger
//
//  Created by 정정욱 on 3/18/24.
//

import Foundation

// 프로필을 눌렀을 때 각각의 다른 뷰로 이동시키기 위해 열거형 구현 내 프로필을 프로필 뷰로 상대방 프로필 누르면 채팅 뷰로 이동
enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
