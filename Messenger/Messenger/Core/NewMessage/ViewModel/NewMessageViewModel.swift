//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/12/24.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {

    @Published var users = [User]()

    init() {
        Task { try await fetchUsers() }
    }

    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers() // UserService.shared로 안함 공유 인스턴스를 사용할 필요가 없어서 (그냥 전체 사용자만 가져오는거라)
        
        //UserService는 전체 사용자 리스트만 가져오고 내 자신과는 채팅하고 싶지 않기때문에 필터링을 걸어주는 로직을 아래와 같이 작성
        self.users = users.filter({ $0.id != currentUid })
    }
}
