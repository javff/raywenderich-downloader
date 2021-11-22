//
//  AboutView.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 22-11-21.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @State var isPresented = false

    var body: some View {
        VStack {
            VStack {
                Header()
                ProfileText()
            }
            Spacer()
        }
    }
}

struct ProfileText: View {
    var name = "Juan Vasquez"
    var subtitle = "lorem it sum"
    var description = "description"
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title)
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}


struct Header: View {

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color.blue)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            
            VStack(alignment: .leading, spacing: 80) {
                Image("profile")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
#endif
