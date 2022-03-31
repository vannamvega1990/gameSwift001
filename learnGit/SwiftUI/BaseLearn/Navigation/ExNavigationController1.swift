////
////  ExNavigationController1.swift
////  learnGit
////
////  Created by tran dinh thong on 8/22/21.
////
//
//import SwiftUI
//
//@available(iOS 13.0, *)
//extension View {
//    func tripleEmptyNavigationLink()-> some View {
//        self.modifier(TripleEmptyNavigationLinkBackground())
//    }
//}
//
//@available(iOS 13.0, *)
//struct TripleEmptyNavigationLinkBackground: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .background(TripleEmptyNavigationLink())
//    }
//}
//
//@available(iOS 13.0, *)
//struct TripleEmptyNavigationLink: View {
//    var body: some View {
//        VStack {
//        NavigationLink(destination: EmptyView()) {EmptyView()}
//        NavigationLink(destination: EmptyView()) {EmptyView()}
//        NavigationLink(destination: EmptyView()) {EmptyView()}
//            
//        }
//    }
//}
//
//@available(iOS 13.0, *)
//struct SecondView: View {
//    var body: some View {
//        Text("This is the detail view")
//    }
//}
//
//@available(iOS 13.0, *)
//struct ExNavigationController1: View {
//    
//    var body: some View {
//        NavigationView {
//            
//            VStack {
//                NavigationLink(destination: SecondView()) {
//                    Text("Show Detail View")
//                }
//                
//                List {
//                    Text("1")
//                    NavigationLink(destination: Text("1")) {
//                        Text("Show Detail View")
//                    }
//                    NavigationLink(destination: Text("2")) {
//                        Text("2")
//                    }
//                    NavigationLink(destination: Text("3")) {
//                        Text("3")
//                    }
//                }
//            }
//            
//        }
//        
//        
//        
////        VStack {
////                NavigationLink(destination: EmptyView()) {EmptyView()}
////                NavigationLink(destination: EmptyView()) {EmptyView()}
////                NavigationLink(destination: EmptyView()) {EmptyView()}
////
////                }
////        NavigationLink(destination: Text(item.name)) {
////            // existing contents…
////        }
//    }
//}
//
//@available(iOS 13.0, *)
//struct ExNavigationController1_Previews: PreviewProvider {
//    static var previews: some View {
//        ExNavigationController1()
//    }
//}
