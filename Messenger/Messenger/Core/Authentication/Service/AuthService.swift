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

    func login(withEmail email: String, password: String) async throws {
        print("DEBUG: email is \(email)")
        print("DEBUG: passowrd is \(password)")
    }

    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("Created user \(result.user.uid)") // 등록시 uid를 반환
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }

}
