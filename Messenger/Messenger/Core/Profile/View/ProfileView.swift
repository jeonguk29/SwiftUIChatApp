//
//  ProfileView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.


import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
        VStack {
            // header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    // 내부적 처리는 뷰 모델을 통해 하는것을 권장함 
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xLarge)
                    }
                }
                Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            // list
            List {
                Section {
                    // 식별 가능한 프로토콜을 채택해서 따로 id: \.self 이런거 필요 없음 
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)

                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }

                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                    }

                    Button("Delete Account") {

                    }
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)

}
