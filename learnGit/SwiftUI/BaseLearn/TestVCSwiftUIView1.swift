//
//  TestVCSwiftUIView1.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import SwiftUI

//let swiftUIView = ContentView() // swiftUIView is View
//let viewCtrl = UIHostingController(rootView: swiftUIView)

extension Button {
    var testVar:String {
        get{
            return "123"
        }
    }
    func testFunction(){
        background(Color.black)
        print("---------")
    }
}

struct SubView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct Data: Identifiable {
    var id = UUID()
    let title: String
    let imageName: String
    let imageDes: String
    let imageTokenDate: String
}

struct ContentView: View {
    
    @State private var showDetails = false
    @State private var didTap:Bool = false
    
    
    var items:[Data] = [Data(id: .init(), title: "123test", imageName: "pic1", imageDes: "day la pic 1", imageTokenDate: "123")]
    
    func actionOfButton() {
        print("Hello, world!")
    }
    
    var body: some View {
        
        if showDetails {
            Text("You should follow me on Twitter: @twostraws")
                .font(.largeTitle)
        }
        
        VStack{
            NavigationView {
                List(items){data in
                    Image(data.imageName).resizable().frame(width: 98, height: 98, alignment: .center)
                    Text(data.imageDes).foregroundColor(.green).fontWeight(.bold)
                    SubView()
                }.navigationBarTitle("123")
            }
            
            //  change color button ---------------------------
            Button(action: {
                //self.didTap = true
                self.didTap.toggle()
            }) {
                Text("My custom button").font(.system(size: 24))
            }
            .frame(width: 300, height: 75, alignment: .center)
            .padding(.all, 20)
            .background(didTap ? Color.red : Color.yellow)
            //  ---------------------------
            Button("btn") {
                showDetails.toggle()
            }
            //  ---------------------------
            Button("tap") {
                actionOfButton()
                
            }.foregroundColor(.red)
        }
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
