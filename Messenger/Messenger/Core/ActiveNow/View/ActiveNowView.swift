//
//  ActiveNowView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users, id: \.self) { user in
                    NavigationLink(value: Route.chatView(user)) {
                        // 상위 뷰에서 정의한대로 이동 됨 ⭐️
                        VStack {
                            ZStack (alignment: .bottomTrailing){
                                CircularProfileImageView(user: user, size: .medium)
                                
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                            }
                            
                            Text(user.fullname)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        } //:VSTACK
                    }
                }//:ForEach
            } //:HSTACK
            .padding()
        } //:SCROLL
        .frame(height: 106)
    }
}

#Preview {
    ActiveNowView()
}
