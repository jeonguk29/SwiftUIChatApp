//
//  NewMessageView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct NewMessageView: View {
    
    @State private var searchText = ""
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User? // 채팅을 시작할 사용자
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                // Identifiable를 따라서 id: \.self 필요 없음
                ForEach(viewModel.users) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        } //:HSTACK
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 40)
                    } //:VSTACK
                    .onTapGesture {
                        selectedUser = user
                        dismiss() // 이미 풀스크린으로 올라온 화면이라 화면 내리고 채팅 뷰로 이동해야함
                        
                    }
                }
            }//:SCROLL
            // 네비게이션 아이템만 사용하지 않을뿐 혼용사용 가능
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
        }  //:NAVIGATION
    }
}

#Preview {
    NavigationStack {
        NewMessageView(selectedUser: .constant(User.MOCK_USER))
    }
}
