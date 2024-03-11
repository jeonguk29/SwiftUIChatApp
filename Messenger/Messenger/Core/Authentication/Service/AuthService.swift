//
//  AuthService.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import Foundation
import Firebase


// Firebase와 통신과 관련된 모든 코드를 넣을 것임 사용자 로그인, 등륵 등등 
class AuthService {
  
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService() // 싱글톤으로 이로직을 구현하지 않으면 여러 인스턴스가 생기기 때문에
    // 로그인, 로그아웃을 하더라도 View가 반영되지 않을 수 있음 init 될때마다 userSession가 새로 생기기 때문임
    
    init() {
        self.userSession = Auth.auth().currentUser // 로그인 했다면 로그인 정보 로컬에 저장됨 
        print("User session id is \(userSession?.uid)")
    }

    func login(withEmail email: String, password: String) async throws {
           do {
               let result = try await Auth.auth().signIn(withEmail: email, password: password)
               self.userSession = result.user // 로그인 하면 세션에 결과 넣어주기
               //변경시 컨텐츠 View또한 업데이트 됨
           } catch {
               print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
           }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
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
}
