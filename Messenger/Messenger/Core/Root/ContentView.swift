//
//  ContentView.swift
//  Messenger
//
//  Created by 정정욱 on 3/8/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                InboxView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
