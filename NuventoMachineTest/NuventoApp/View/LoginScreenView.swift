//
//  LoginScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var vm = AuthViewModel()
    @State private var user = ""
    @State private var pass = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geo in
                    VStack {
                        TextField("Username", text: $user)
                            .textFieldStyle(.roundedBorder)
                        SecureField("Password", text: $pass)
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                        Button(action: {
                            Task { await vm.login(username: user, password: pass) }
                        }, label: {
                            Text("Login")
                                .frame(width: geo.size.width/1.15, height: 40, alignment: .center)
                        })
                        .frame(width: geo.size.width/1.15, height: 40, alignment: .center)
                        .font(Font.system(size: 20, weight: .bold))
                        .background(.purple)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                        .clipped()
                    }.padding()
                }
            }
            .navigationTitle("Login")
            .onAppear(perform: {
                vm.silentAuth()
            })
            //            .navigationDestination(isPresented: $vm.isLoggedIn, destination: {
            //                HomeScreenView()
            //            })
        }
    }
}

#Preview {
    LoginScreenView()
}
