//
//  SettingsOptionsViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import Foundation
import SwiftUI

/*
 CaseIterable를 채택하면 ForEach문 사용시 배열처럼 모든 사례를 하나씩 처리할 수 있음 
 */
enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications

    var title: String {
        switch self {
        case .darkMode: return "다크 모드"
        case .activeStatus: return "활동 상태"
        case .accessibility: return "접근성"
        case .privacy: return "개인 정보"
        case .notifications: return "알림 설정"
        }
    }

    var imageName: String {
        switch self {
        case .darkMode: return "moon.circle.fill"
        case .activeStatus: return "message.badge.circle.fill"
        case .accessibility: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }

    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: return .black
        case .activeStatus: return Color(.systemGreen)
        case .accessibility: return .black
        case .privacy: return Color(.systemBlue)
        case .notifications: return Color(.systemPurple)
        }
    }

    var id: Int { return self.rawValue } // 각 case에 원시값 0,1,2를 반환하여 View에 변화를 주고 동작을 처리
}
