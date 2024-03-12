//
//  InboxViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/12/24.
//

import Foundation
import Combine
import Firebase


class InboxViewModel: ObservableObject {

    @Published var currentUser: User?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers() // 데이터 구독 설정
    }
    
    // 로그인된 사용자를 감시하여 변경일어나면 알맞게 대화중인 메시지 및 프로필 뷰를 보여줄 것임
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }

}
