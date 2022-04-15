//
//  EditFriendModal.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/23/21.
//
import SwiftUI

struct EditFriendModal: View {
    @Binding var friends: [Person]
    @Binding var isEditFriendOpen: Bool
    
    @State var firstName: String
    @State var lastName: String
    
    @State var editFriendIndex: Int?
    
    let saveAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("First Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("First Name", text: $firstName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                Section(header: Text("Last Name").font(.system(size: 20, weight: .semibold))) {
                    TextField("Last Name", text: $lastName)
                        .foregroundColor(.black)
                }
                    .foregroundColor(.white)
                
                HStack {
                    Button(action: {closePopup()}) {
                        Text("Cancel")
                    }
                        .buttonStyle(GreenButton())
                    
                    Spacer()
                    
                    Button(action: {saveFriend()}) {
                        Text("Save")
                    }
                        .buttonStyle(GreenButton())
                }
                    .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
            }
                .frame(width: 350, height: 300, alignment: .center)
                .padding(.bottom, 30)
                .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
        }
    }
    
    func saveFriend() {
        if (firstName == "") {
            return
        }
        
        if (editFriendIndex != nil) {
            let originalColor = friends[editFriendIndex!].color
            friends[editFriendIndex!] = Person(firstName: firstName, lastName: lastName, color: 0)
            friends[editFriendIndex!].color = originalColor
        } else {
            friends.append(Person(firstName: firstName, lastName: lastName, color: friends.count % DVYColors.count))
        }
        
        saveAction()
        closePopup()
    }
    
    func closePopup() {
        self.isEditFriendOpen = false
    }
}
