//
//  ContentView.swift
//  VKSwiftUI
//
//  Created by Jane Z. on 21.04.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    //созданы переменные для textField и фона
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    
    //методы для того чтоб скрывалась клавиатура по тапу на экран
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map{ _ in false }
    )
        .removeDuplicates()
    
    //Элементы View
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("MainVK")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: geometry.size.width, maxHeight:
                            geometry.size.height)
            }
            ScrollView {
                VStack{
                    Text("Wellcom to VK :)")
                        .padding(.top, 32)
                        .font(.largeTitle)
                    HStack {
                        Text("Login:")
                        Spacer()
                        TextField("", text: $login)
                            .frame(maxWidth: 150)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Password:")
                        Spacer()
                        SecureField("", text: $password)
                            .frame(maxWidth: 150)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                } .frame(maxWidth: 250)
                Button(action: { print("Hello")}) {
                    Text("Log in")
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                .disabled(login.isEmpty || password.isEmpty)
            }
        }
        .onReceive(keyboardIsOnPublisher) { isKeyboardOn in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.shouldShowLogo = !isKeyboardOn
            }
        }.onTapGesture {
            UIApplication.shared.endEditing() }
        }
    }
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
        
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
