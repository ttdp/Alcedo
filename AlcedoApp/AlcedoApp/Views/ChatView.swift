//
//  ChatView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    let currentUser: Contact
    let receiver: Contact
    
    @State var count = 0
    
    @State private var messages: [Message] = [
        Message(id: 0, text: "Morbi scelerisque luctus velit", contact: Contact(id: "id", name: "Name", avatar: nil, isOnline: true)),
        Message(id: 1, text: "Pellentesque ipsum. Mauris elem enes tumen mauris vitae tortor. Pellentesque ipsum. ", contact: Contact(id: "id", name: "Name", avatar: nil, isOnline: true)),
        Message(id: 2, text: "Phasellus enim erat esi, vestibulum veles?", contact: Contact(id: "me", name: "Name", avatar: nil, isOnline: true)),
        Message(id: 3, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", contact: Contact(id: "id", name: "Name", avatar: nil, isOnline: true)),
        Message(id: 4, text: "Mauris tincidunt sem", contact: Contact(id: "me", name: "Name", avatar: nil, isOnline: true)),
    ]
    
    init(currentUser: Contact, receiver: Contact) {
        self.currentUser = currentUser
        self.receiver = receiver
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.top)
            
            VStack {
                List {
                    ForEach(0..<messages.count, id: \.self) { i in
                        ChatMessageRow(
                            message: self.messages[i],
                            isIncoming: self.messages[i].contact.id != self.currentUser.id,
                            isLastFromContact: self.isMessageLastFromContact(at: i))
                            .listRowInsets(EdgeInsets(
                                top: i == 0 ? 16 : 0,
                                leading: 12,
                                bottom: self.isMessageLastFromContact(at: i) ? 20 : 6,
                                trailing: 12))
                    }
                }
                .onTapGesture {
                    self.endEditing()
                }
                
                ChatTextField(sendAction: onSendTapped)
                    .padding(.bottom, keyboardObserver.keyboardHeight)
            }
            .edgesIgnoringSafeArea(keyboardObserver.keyboardHeight == 0.0 ? .leading: .bottom)
            .animation(.easeInOut(duration: 0.3))
            
        }
        .navigationBarTitle(Text(receiver.name), displayMode: .inline)
    }
    
    private func isMessageLastFromContact(at index: Int) -> Bool {
        let message = messages[index]
        let next = index < messages.count - 1 ? messages[index + 1] : nil
        return message.contact != next?.contact
    }
    
    private func onSendTapped(message: String) {
        let urlSession = URLSession(configuration: .default)
        let webSocketTask = urlSession.webSocketTask(with: URL(string: "ws://127.0.0.1:8080/alcedo")!)
        webSocketTask.resume()
        
        let message = URLSessionWebSocketTask.Message.string("Hello, Alcedo!")
        webSocketTask.send(message) { error in
            if let error = error {
                print("Web Socket Error: \(error.localizedDescription)")
            }
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        ChatView(
            currentUser: Contact(id: "me", name: "Me", avatar: nil, isOnline: true),
            receiver: Contact(id: "other", name: "Other", avatar: nil, isOnline: true)
        )
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
