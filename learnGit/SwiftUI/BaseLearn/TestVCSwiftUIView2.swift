//
//  TestVCSwiftUIView2.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import SwiftUI

struct TestVCSwiftUIView2: View {
    @State var kind = Text.Kind.primary

    var body: some View {
        VStack {
            
        Text("Primary")
            .style(kind)
            Button(action: {
                self.kind = .secondary
            }) {
                Text("Change me to secondary")
            }.Handle()
        }
    }
}

struct TestVCSwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        TestVCSwiftUIView2()
    }
}

extension View {
   
    func Handle() -> some View{
        print("-----------")
        let v = SubView().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        return self.background(Color.red)
    }
}

extension UIImage {
    func Handle() -> some UIImage{
        print("-----------")
        return self.withTintColor(UIColor.red)
    }
}

extension UIImageView {
    func Handle1(){
        print("-----------")
        self.image = UIImage()
    }
}

extension Text {
    enum Kind {
        case primary
        case secondary
    }

    func style(_ kind: Kind) -> some View {

        switch kind {
        case .primary:
            return self
                .padding()
                .background(Color.black)
                .foregroundColor(Color.white)
                .font(.largeTitle)
                .cornerRadius(10)

        case .secondary:
            return self
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .cornerRadius(20)
        }
    }
}


