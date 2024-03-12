//
//  AuthService.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// Firebase와 통신과 관련된 모든 코드를 넣을 것임 사용자 로그인, 등륵 등등 
class AuthService {
  
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService() // 싱글톤으로 이로직을 구현하지 않으면 여러 인스턴스가 생기기 때문에
    // 로그인, 로그아웃을 하더라도 View가 반영되지 않을 수 있음 init 될때마다 userSession가 새로 생기기 때문임
    
    init() {
        self.userSession = Auth.auth().currentUser // 로그인 했다면 로그인 정보 로컬에 저장됨 
        Task { try await UserService.shared.fetchCurrentUser() } // 로그인 했다면 정보 가져오기
        print("User session id is \(userSession?.uid)")
    }

    @MainActor
    func login(withEmail email: String, password: String) async throws {
           do {
               let result = try await Auth.auth().signIn(withEmail: email, password: password)
               self.userSession = result.user // 로그인 하면 세션에 결과 넣어주기
               //변경시 컨텐츠 View또한 업데이트 됨
           } catch {
               print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
           }
    }
    
    // 보라색 오류 없애는 방법 
    @MainActor //사용자를 생성하고 사용자 데이터를 업로드하는 API 호출을 시작할때 백그라운드 스레드에서 진행 되기 때문에 다시 메인 스레드로 돌아오게 지시해줘야함 dispatchq.main,async와 동일함 최신 방식
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await self.uploadUserData(email: email, fullname: fullname, id: result.user.uid)
            print("Created user \(result.user.uid)") // 등록시 uid를 반환
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out on backend
            self.userSession = nil // update routing logic
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    /// 실제 사용자 정보를 컬렉션에 생성하는 함수
    /// - Parameters:
    ///   - email, fullname, id : createUser메서드에서 넘겨 받는 값들
    /// - Returns: 없음
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, profileImageUrl: nil) // 비번저장하면 소송걸림 ㅋㅋ
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return } //⭐️
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}
