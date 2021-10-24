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
    @Binding var isFriendActionOpen: Bool
    
    @State var firstName: String
    @State var lastName: String
    @State var actionFriendIndex: Int?
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            if (isEditFriendOpen) {
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
                        Button(action: {closeEditPopup()}) {
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
                    .padding(.top, 15)
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                    }
                    .onDisappear {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
            }
            
            if (isFriendActionOpen) {
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 15)
                        .onTapGesture() {
                            closeActionPopup()
                        }
                    
                    Image(systemName: "trash.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 15)
                        .onTapGesture() {
                            deleteFriend()
                        }
                    
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 15)
                }
                    .frame(width: 225, height: 75, alignment: .center)
                    .padding(.top, 15)
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1)).cornerRadius(15)
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                    }
                    .onDisappear {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
            }
        }
    }
    
    func saveFriend() {
        if (firstName == "" || lastName == "") {
            return
        }
        
        friends.append(Person(firstName: firstName, lastName: lastName, color: friends.count % DVYColors.count))
        closeEditPopup()
    }
    
    func closeEditPopup() {
        self.isEditFriendOpen = false
    }
    
    func closeActionPopup() {
        isFriendActionOpen = false
    }
    
    func deleteFriend() {
        friends.remove(at: actionFriendIndex!)
        self.isFriendActionOpen = false
    }
}
