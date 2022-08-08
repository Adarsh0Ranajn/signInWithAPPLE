//
//  ContentView.swift
//  appleSignIn
//
//  Created by Roro Solutions on 08/08/22.
//
import AuthenticationServices
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email : String = ""
    @AppStorage("firstName") var firstName : String = ""
    @AppStorage("lastName") var lastName : String = ""
    @AppStorage("userID") var userID : String = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                SignInWithAppleButton(.continue){ request in
                    request.requestedScopes = [.email, . fullName]
                    
                }  onCompletion: { result in
                    switch result {
                    case .success(let auth):
                        switch  auth.credential{
                        case let credential as ASAuthorizationAppleIDCredential:
                            let userId = credential.user
                            
                            let email = credential.email
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            
                            self.email = email ?? ""
                            self.firstName = firstName ?? ""
                            self.lastName = lastName ?? ""
                            self.userID = userId
                        default:
                            print("errror")
                            
                        }
                   
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .black
                )
                .frame (height: 50 )
                .padding()
                .cornerRadius(8)
                
                
            }.navigationTitle("SignIn")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
