//
//  TestVCSwiftUIView3.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import SwiftUI
import UIKit

// UIView To View ------------------------

struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}


// editing Textfild ---------------------

struct ContentView1: View {

    var colll:Color = .red
    @State private var email = ""
    @State private var editing = false
    var body: some View {
        TextField("Email", text: self.$email, onEditingChanged: { edit in
            self.editing = edit
        })
            .textFieldStyle(MyTextFieldStyle(focused: $editing)).font(.title).border(Color.blue)
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(focused ? Color.red : Color.gray, lineWidth: 3)
        ).padding()
    }
}

// ------------------------




struct TestVCSwiftUIView3: View {
    @State var text = NSMutableAttributedString(string: "123")
    
    var body: some View {
        TextView(text: $text)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct TestVCSwiftUIView3_Previews: PreviewProvider {
    static var previews: some View {
        //TestVCSwiftUIView3()
        ContentView1()
    }
}
