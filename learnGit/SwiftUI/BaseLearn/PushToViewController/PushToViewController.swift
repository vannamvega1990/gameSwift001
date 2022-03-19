//
//  PushToViewController.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import SwiftUI



class Model: ObservableObject {
    @Published var pushed = false
}

struct PushToViewController: View {
    
    @EnvironmentObject var model: Model

    var body: some View {
        NavigationView {
            VStack {
                Button("Push") {
                    self.model.pushed = true
                }

                NavigationLink(destination: DetailView(), isActive: $model.pushed) { EmptyView() }
            }
        }
    }
}

struct DetailView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        Button("Bring me Back") {
            self.model.pushed = false
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: MyBackButton(label: "Back!") {
            self.model.pushed = false
        })
    }
}

struct MyBackButton: View {
    let label: String
    let closure: () -> ()

    var body: some View {
        Button(action: { self.closure() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}

struct PushToViewController_Previews: PreviewProvider {
    static var previews: some View {
        PushToViewController()
    }
}




