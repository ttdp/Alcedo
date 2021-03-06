//
//  AppStore.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/23.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation
import Combine

enum ServiceEnum {
    case ticket(URL)
    case member(URL)
}

extension ServiceEnum {
    var isTicket: Bool {
        switch self {
        case .ticket(_):
            return true
        case .member(_):
            return false
        }
    }
}

class AppStore: ObservableObject {
    
    let http = HTTP(base: "http://127.0.0.1:8080/")
    
    @Published var categories: [Category] = []
    
    func loadLanding() {
        http.get("categories") { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    self.categories = (try? JSONDecoder().decode([Category].self, from: data)) ?? []
                }
            }
        }
    }
    
}
