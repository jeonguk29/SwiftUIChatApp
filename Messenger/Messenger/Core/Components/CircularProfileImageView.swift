//
//  CircularProfileImageView.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI


// 동적으로 사이즈를 만들도록 열거형 정의
enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 56
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

// 프로필 이미지가 너무 자주 사용됨 재사용 가능하게 만들기
struct CircularProfileImageView: View {

    var user: User?
    let size: ProfileImageSize

    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension) // 동적 사이즈 지정 
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USER, size: .medium)
}
