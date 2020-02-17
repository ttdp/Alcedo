//
//  TitleText.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct TitleText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.bold))
            .foregroundColor(.cometChatBlue)
    }
    
}
