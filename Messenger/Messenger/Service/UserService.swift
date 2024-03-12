//
//  UserService.swift
//  Messenger
//
//  Created by 정정욱 on 3/11/24.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift


// 모든 사용자 정보관련 로직을 처리할 클래스임
class UserService {

    @Published var currentUser: User?

    static let shared = UserService()

    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        print("What is snapshot : \(snapshot)")
        let user = try snapshot.data(as: User.self) // 가져온 스냅샷 데이터를 디코딩 
        self.currentUser = user
        print("DEBUG: current user in service is \(user)")
    }

}
