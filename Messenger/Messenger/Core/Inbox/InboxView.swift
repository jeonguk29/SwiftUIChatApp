//
//  InboxView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct InboxView: View {
    
    @State private var showNewMessageView = false
    
    @State private var user = User.MOCK_USER
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                
                // 리스트로 만들어야 채팅을 삭제, 추가했을때 용이함
                List {
                    ForEach(0...10, id:\.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(PlainListStyle())
                
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .navigationDestination(for: User.self, destination: { user in
                     ProfileView(user: user)
                 })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView()
            })
            
            // toolbar 사용법
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        /*
                         // Navigation Link 에서 value 값을 넘겨주고 navigationDestination 으로 값을 넘겨 줄수 있음
                                    // (Navigation Link 의 value type 을 파악해서 넘김
                         */
                        NavigationLink(value: user) {
                            Image(user.profileImageUrl ?? "")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)

                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }// ctoolber
        }
    }
}

#Preview {
    InboxView()
}
