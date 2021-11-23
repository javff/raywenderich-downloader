//
//  AboutView.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 22-11-21.
//

import SwiftUI

import SwiftUI

enum Contact: String, CaseIterable {
    case whatsapp, linkedin, gmail, github
    
    var name: String {
        return self.rawValue
    }
    
    var data: String {
        switch self {
        case .github: return "https://github.com/javff"
        case .gmail: return "javff2@gmail.com"
        case .whatsapp: return "https://api.whatsapp.com/send?phone=56981499700"
        case .linkedin: return "https://www.linkedin.com/in/juan-vasquez-ferrer-108741116/"
        }
    }
}

class ActionExecutor {
    func execute(from action: Contact) {
        guard let url = URL(string: action.data) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Header()
                ProfileText()
            }
            Spacer()
        }
    }
}

struct ProfileText: View {
    let name = "Juan Vásquez"
    let subtitle = "IOS Developer 🍏 📱"
    let footer = """
        Do you want any special features?
        Would you like to contribute?
        Contact me.
    """
    
    var contacts: [Contact] = Contact.allCases
    var actionExecutor = ActionExecutor()
    
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
            HStack(spacing: 25) {
                    ForEach(contacts, id: \.self) { (element) in
                        Image(element.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .onTapGesture {
                                actionExecutor.execute(from: element)
                            }
                    }
            }.padding(.horizontal, 20)
            Spacer()
            Text(footer)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}


struct Header: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color(hex: "#f54f32"))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 150)
           
            Image("JavffProfile")
                .resizable()
                .scaledToFill()
                .frame(width: 215, height: 215)
                .offset(x: 0, y: 15)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .offset(x: 0, y: 25)
                
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
