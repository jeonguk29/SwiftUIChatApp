//
//  InboxView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct InboxView: View {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "person.circle.fill")

                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)

                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Show new message view")
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
