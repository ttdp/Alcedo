//
//  ContactRow.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ContactRow: View {
    
    struct ContactItem: Identifiable {
        let contact: Contact
        let lastMessage: String
        let unread: Bool
        
        var id: String { contact.id }
    }
    
    let item: ContactItem
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                AvatarView(url: nil, isOnline: item.contact.isOnline)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    Text(item.contact.name)
                        .foregroundColor(.body)
                        .fontWeight(item.unread ? .medium : .regular)
                    .lineLimit(1)
                    
                    Text(item.lastMessage)
                        .foregroundColor(.body)
                        .font(.system(size: 12))
                        .fontWeight(item.unread ? .medium : .regular)
                    .lineLimit(1)
                        .padding(.top, 2)
                }
                .padding(.leading, 10)
                .padding(.trailing, 20)
                
                Spacer()
            }
            
            Spacer()
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(UIColor.separator))
        }
        .background(item.unread ? Color(red: 236 / 255, green: 240 / 255, blue: 254 / 255) : nil)
        .frame(maxWidth: .infinity)
        .frame(height: 67)
    }
    
}

struct Contact_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContactRow(item: ContactRow.ContactItem(contact: Contact(id: "0", name: "Some Name", avatar: nil, isOnline: true), lastMessage: "Last message is a pretty big message", unread: true))
                .previewLayout(.fixed(width: 300, height: 67))
            
            ContactRow(item: ContactRow.ContactItem(contact: Contact(id: "1", name: "Other Name", avatar: nil, isOnline: false), lastMessage: "Last message is a pretty big message", unread: false))
                .previewLayout(.fixed(width: 300, height: 67))
        }
    }
}
