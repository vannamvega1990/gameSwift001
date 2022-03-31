//
//  PushToViewController.swift
//  learnGit
//
//  Created by tran dinh thong on 8/16/21.
//

import SwiftUI



@available(iOS 13.0, *)
class Model: ObservableObject {
    @Published var pushed = false
}

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
struct PushToViewController_Previews: PreviewProvider {
    static var previews: some View {
        PushToViewController()
    }
}




