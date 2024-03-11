//
//  RegistrationViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.


import SwiftUI

class RegistrationViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
