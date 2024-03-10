//
//  ProfileView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.


import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            // header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color(.systemGray4))
                    }
                }
                Text("Bruce Wayne")
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
    ProfileView()
}
