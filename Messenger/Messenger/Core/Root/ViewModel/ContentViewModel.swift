//
//  ContentViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/11/24.
//

import Firebase
import Combine

class ContentViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    // 인증 사용자를 확인하고 인증 되었다면 채팅 뷰를 보여줄 것임
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    // 컴바인을 사용하여 업데이트를 수신 하는 방법
    private func setupSubscribers() { // listen for updates using combine
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }

}
