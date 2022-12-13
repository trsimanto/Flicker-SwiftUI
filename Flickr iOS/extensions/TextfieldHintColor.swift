//
//  TextfieldHintColor.swift
//  Flickr iOS
//
//  Created by REEA on 12/12/22.
//

import Foundation
import SwiftUI
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
