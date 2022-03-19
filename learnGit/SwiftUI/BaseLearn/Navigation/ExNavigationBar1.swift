//
//  ExNavigationBar1.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import SwiftUI

struct ExNavigationBar1: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationTitle("Navigation")
//                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ExNavigationBar1_Previews: PreviewProvider {
    static var previews: some View {
        ExNavigationBar1()
    }
}
