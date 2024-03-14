//
//  InboxView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct InboxView: View {
    
    @State private var showNewMessageView = false
    
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User? // 채팅을 시작할
    /*
     NewMessageView에 해당 User 객체를 바인딩해줘서 NewMessageView에서 사용자를 선택하면 InboxView 돌와와서 해당 선택한 사용자와 함께 ChatView로 이동
     */
    @State private var showChat = false
    
    private var user: User? { // 뷰모델에서 로그인 사용자를 구독하여 변경되면 값을 담을 것임
        return viewModel.currentUser
    }
    
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
            .onChange(of: selectedUser) {
                showChat = true 
                //1. 채팅할 사용자를 NewMessageView에서 선택하고 돌아오면
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                    //2. 채팅할 사용자를 넘겨 채팅을 시작
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
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
                            CircularProfileImageView(user: user, size: .xSmall)
                        }
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil // 이걸 해줘야 동일한 사용자를 다시 선택했을때 ChatView로 들어가지지 않는 Bug해결이 가능 동일 사용자라면 onChange가 작동하지 않기 때문임
                        
                        
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
