//
//  CustomTextField.swift
//  WordCinameApp
//
//  Created by Денис Большачков on 10.03.2022.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: String
    @Binding var text: String
    var placeholder: Text
    var editingChanged: (Bool) -> () = {_ in}
    var commit: ()->() = {}
    
    var body: some View {
        HStack{
            if !text.isEmpty {
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    .foregroundColor(Color.FontColor)
                
            }
            else {
                placeholder
                    .foregroundColor(Color.FontColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
            }
        }
        .padding()
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.FontColor, lineWidth: 1)
        )
        
    }
}
