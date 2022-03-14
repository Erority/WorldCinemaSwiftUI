//
//  SignInScreen.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var emailText: String = "E-mail"
    @State private var passwordText: String = "Пароль"
    
    @State private var selection: String? = nil
    
    @State private var isShowEmailAlert = false
    @State private var isShowPasswordAllert = false

    
    var body: some View {
        NavigationView{
            VStack{
                
                NavigationLink(destination: SignUpScreen().navigationBarHidden(true), tag: "SignUpScreen", selection: $selection) {
                    EmptyView()
                }
                NavigationLink(destination: MainScreen().navigationBarHidden(true), tag: "MainScreen", selection: $selection) {
                    EmptyView()
                }
                
                Image("LogoWithText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 82)
                    .padding(.leading, 86)
                    .padding(.top, 132)
                
                TextField("E-mail", text: $emailText)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.leading, 17)
                    .padding(.trailing, 15)
                    .padding(.top, 104)
                    .onTapGesture {
                        if self.emailText == "E-mail" {
                            self.emailText = ""
                        }
                    }
                
                
                TextField("Пароль", text: $passwordText)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        if self.emailText == "Пароль" {
                            self.emailText = ""
                        }
                    }
                
                
                Spacer()
                
                VStack{
                    AccentButton(title: "Войти", action: {
                        if validation(){
                            Api().authUser(userData: PostUserDataForAuth(email: emailText, password: passwordText)) { model in
                                
                                selection = "MainScreen"
                            }
                        }
                    })
                        .padding(.leading, 18)
                        .padding(.trailing, 14)
                    
                    SecondButton(title: "Регистрация", action: {
                        selection = "SignUpScreen"
                    })
                        .padding(.leading, 18)
                        .padding(.trailing, 14)
                }
                .padding(.bottom, 78)
                
                
            }
            .ignoresSafeArea()
            .background(Color.BackgroundColor)
            .alert("Заполните почту", isPresented: $isShowEmailAlert) {
                
            }
            .alert("Заполните пароль", isPresented: $isShowPasswordAllert) {
                
            }
        }
    }
    
    func validation() -> Bool{
        if emailText.isEmpty {
            isShowEmailAlert = true
            return false
        } else if passwordText.isEmpty {
            isShowPasswordAllert = true
            return false
        }
        return true
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}

