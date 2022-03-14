//
//  WordCinameAppApp.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

@main
struct WordCinameAppApp: App {
    
    let defaults = UserDefaults.standard
    let isFirstTry: Bool
    
    init(){
        isFirstTry = defaults.bool(forKey: "isFirstTry")
    }
    
    var body: some Scene {
        WindowGroup {
            if isFirstTry {
                SignUpScreen()
            } else {
                SignInScreen()
            }
        }
    }
}
