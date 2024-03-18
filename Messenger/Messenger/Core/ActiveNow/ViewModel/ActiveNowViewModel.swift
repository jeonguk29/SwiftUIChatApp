//
//  ActiveNowViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/18/24.
//


import Foundation
import Firebase

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task { try await fetchUsers() }
    }

    // 사용자 개수의 따라 Cell 즉 UI가 변경되서 해줘야함 
    @MainActor
    private func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers(limit: 10)
        self.users = users.filter({ $0.id != currentUid })
    }
}
