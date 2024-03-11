//
//  LoginViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    func login () async throws {
        try await AuthService().login(withEmail: email, password: password)
    }
}
