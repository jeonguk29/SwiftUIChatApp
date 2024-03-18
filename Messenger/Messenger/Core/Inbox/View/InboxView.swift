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
            
            // 리스트로 만들어야 채팅을 삭제, 추가했을 때 용이함
            // 스크롤 뷰가 따로 노는 에러를 해결하기 위해 리스트 안에서 전체적인 UI 위치 수정
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden) // 리스트 구분선 안보이게
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                ForEach(viewModel.recentMessages) { message in
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }.opacity(0.0) // 가려서 안보이게 하기 InboxRowView를 눌렀을때 이동하는 것 처럼 하기위해 ZStack을 사용
                        
                        InboxRowView(message: message)
                    }
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(PlainListStyle())
            
            
            .onChange(of: selectedUser) {
                showChat = true
                //1. 채팅할 사용자를 NewMessageView에서 선택하고 돌아오면
            }
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user) // 메시지 누르면 채팅뷰로 이동
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                }
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
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircularProfileImageView(user: user, size: .xSmall)
                            }
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
