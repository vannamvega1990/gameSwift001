//
//  ExTableView2.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import SwiftUI

struct ExTableView2: View {
    
    //    @State var fakeData = ["Array A", "Array B", "Array C", "Array D"]
    //
    //    var body: some View {
    //        List(fakeData, id:\.self) { Text($0) }
    //    }
    
    @State var numbers:[Int] = Array(0...10)
    
    var body: some View {
        NavigationView {
            List(numbers, id:\.self) { number in
                HStack {
                    Text("This is number \(number)")
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("background")))
                .padding()
            }
            .navigationTitle("List example")
        }
    }
}

struct ExTableView2_Previews: PreviewProvider {
    static var previews: some View {
        ExTableView2()
    }
}
