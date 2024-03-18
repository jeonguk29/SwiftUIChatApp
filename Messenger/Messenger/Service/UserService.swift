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
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        print("What is snapshot : \(snapshot)")
        let user = try snapshot.data(as: User.self) // 가져온 스냅샷 데이터를 디코딩
        self.currentUser = user
        print("DEBUG: current user in service is \(user)")
    }
    
    /// 채팅을 위한 모든 사용자 정보 가져오는 메서드
    /// - Returns: 파이어베이스에 저장된 모든 사용자들을 반환
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
         let query = FirestoreConstants.usersCollection
         if let limit { query.limit(to: limit) } // 모든 사용자가 아닌 10명 정도로 제한 두기 
         let snapshot = try await query.getDocuments()
         return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
     }
    
    // 임의의 사용자를 가져오는 함수, 비동기 사용 불가 모든 스냅샷 리스너 작업은 컴플리션 핸들러, 콜백을 사용하여 수행됨
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.usersCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
        
        print("위 후행클로저 보다 먼저 실행되는 부분인 비동기 처리랑 똑같음")
    }
}
