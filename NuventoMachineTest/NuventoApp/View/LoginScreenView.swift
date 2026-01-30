//
//  LoginScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct LoginScreenView: View {
    @EnvironmentObject var vm: LoginViewModel
    
    @State private var user = "test"
    @State private var pass = "1234"
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 15.0) {
                    HStack {
                        Text("Login").font(Font.system(size: 40, weight: .bold))
                        Spacer()
                    }
                    TextField("Username", text: $user)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $pass)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button(action: {
                        Task { [weak vm] in
                            await vm?.login(username: user, password: pass)
                        }
                    }, label: {
                        Text("Login")
                            .frame(width: geo.size.width/1.15, height: 40, alignment: .center)
                    })
                    .frame(width: geo.size.width/1.15, height: 40, alignment: .center)
                    .nuventoButtonStyle()
                }.padding()
            }
        }
        .resignKeyboard()
    }
}
