//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by 정정욱 on 3/10/24.
//

import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }

    @Published var profileImage: Image?

    // 이미지 선택후 호출됨 변환하여 사진으로 만드는 메서드
    func loadImage() async throws {
        guard let item = selectedItem else { return }

        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
}
