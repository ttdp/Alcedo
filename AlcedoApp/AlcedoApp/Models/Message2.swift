//
//  Message.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

struct Message2: Hashable, Identifiable {
    var content: String
    var user: User
    
    var id = UUID()
}
