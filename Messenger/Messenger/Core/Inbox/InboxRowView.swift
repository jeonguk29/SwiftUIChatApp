//
//  InboxRowView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color(.systemGray4))

            VStack(alignment: .leading, spacing: 4) {
                 Text("Heath Ledger")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text("Some test message for now that spans more than one line")
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

#Preview {
    InboxRowView()
}
