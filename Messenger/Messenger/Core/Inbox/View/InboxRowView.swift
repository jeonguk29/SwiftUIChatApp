//
//  InboxRowView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

import SwiftUI

struct InboxRowView: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: message.user, size: .medium)

            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(message.timestampString)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            } //:VSTACK

            HStack {
                Text("Yesterday")

                Image(systemName: "chevron.right")
            } //:HSTACK
            
            .font(.footnote)
            .foregroundStyle(.gray)
        } //:HSTACK
        .frame(height: 73)
    }
}

//#Preview {
//    InboxRowView()
//}
