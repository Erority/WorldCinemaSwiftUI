//
//  SignUpScreen.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

struct SignUpScreen: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var firstName = "Имя"
    @State var lastName = "Фамилия"
    @State var emailText = "E-mail"
    @State var passwordText = "Пароль"
    @State var repeatPasswordText = "Повторите пароль"
    
    @State private var firstNameIsNull = false
    @State private var lastNameIsNull = false
    @State private var emailIsNull = false
    @State private var passwordIsNull = false
    @State private var repeatPasswordIsNull = false
    @State private var passwordsIsEqual = false
    
    @State private var selection: String? = nil
    
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView{
            VStack {
                
                NavigationLink(destination: SignInScreen().navigationBarHidden(true), tag: "SignInScreen", selection: $selection) {
                    EmptyView()
                }
                
                Image("LogoWithText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 84)
                    .padding(.top, 88)
                
                TextField("Имя", text: $firstName)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.leading, 17)
                    .padding(.trailing, 15)
                    .padding(.top, 64)
                    .onTapGesture {
                        if self.emailText == "Имя" {
                            self.emailText = ""
                        }
                    }
                
                TextField("Фамилия", text: $lastName)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        if self.emailText == "Фамилия" {
                            self.emailText = ""
                        }
                    }
                
                TextField("E-mail", text: $emailText)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
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
                
                TextField("Повторите пароль", text: $repeatPasswordText)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        if self.emailText == "Повторите пароль" {
                            self.emailText = ""
                        }
                    }
                
                Spacer()
                
                VStack{
                    AccentButton(title: "Зарегистрироваться", action: {
                        if validation() {
                            Api().postUser(userData: PostUserDataForReg.init(email: emailText, password: passwordText, firstName: firstName, lastName: lastName))
                        }
                    })
                        .padding(.leading, 18)
                        .padding(.trailing, 14)
                    
                    SecondButton(title: "У меня уже есть аккаунт", action: {
                        selection = "SignInScreen"
                        
                    })
                        .padding(.leading, 18)
                        .padding(.trailing, 14)
                }
                .padding(.bottom, 78)
            }
            .background(Color.BackgroundColor)
            .ignoresSafeArea()
            .alert("First name is null", isPresented: $firstNameIsNull) {
                
            }
            .alert("Last name is null", isPresented: $lastNameIsNull) {
                
            }
            .alert("Email is null", isPresented: $emailIsNull) {
                
            }
            .alert("Password is null", isPresented: $passwordIsNull) {
                
            }
            .alert("Repeat password is null", isPresented: $repeatPasswordIsNull) {
                
            }
            .alert("Password and repeat password don't equal", isPresented: $passwordsIsEqual) {
                
            }
            .onAppear {
                defaults.set(false, forKey: "isFirstTry")
            }
        }
    }
    
    func validation() -> Bool {
        if emailText.isEmpty {
            self.emailIsNull = true
            return false
        } else if firstName.isEmpty{
            self.firstNameIsNull = true
            return false
        } else if lastName.isEmpty {
            self.lastNameIsNull = true
            return false
        } else if passwordText.isEmpty{
            self.passwordIsNull = true
            return false
        } else if repeatPasswordText.isEmpty {
            self.repeatPasswordIsNull = true
            return false
        } else if passwordText == repeatPasswordText {
            self.passwordsIsEqual = true
            return false
        }
        
        return true
        
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.FontColor, lineWidth: 1)
            )
            .foregroundColor(Color.FontColor)
    }
}
