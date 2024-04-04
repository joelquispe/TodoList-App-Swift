//
//  LoginView.swift
//  app-tasks-swiftui
//
//  Created by joel on 27/11/23.
//

import SwiftUI
import SimpleToast
struct LoginView: View {
    @State private var tfUseranme = ""
    @State private var tfPassword = ""
    
    @State private var showToast = false
    
    @EnvironmentObject var router:Router
    
    private let toastOptions = SimpleToastOptions(
        hideAfter: 3
    )
    
    @State  private var isNavigateHome:Bool = false
    var body: some View {
        
            VStack (spacing: 20){
                Spacer().frame(height:50)
                Image("logo").resizable().scaledToFit().frame(width:120,height: 120)
                Spacer().frame(height:50)
                VStack(alignment:.leading){
                    Text("Username").foregroundStyle(.gray)
                    TextField("Username",text: $tfUseranme)
                        .padding(13)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                VStack(alignment:.leading){
                    Text("Password").foregroundStyle(.gray)
                    SecureField("Password",text: $tfPassword).padding(13).background(Color.gray.opacity(0.2)).cornerRadius(10)
                    
                }
                
                  
                Button(action: {
                    if tfUseranme.isEmpty, tfPassword.isEmpty{
                        
                        showToast.toggle()
                        return
                    }
                    self.router.navigate(to: .home)
                    print("Estas iniciando sesión")
                }) {
                    Text("Iniciar sesión")
                }.padding().background(Color.black).foregroundColor(.white).cornerRadius(10)
                
                // navigation home
                
                Spacer()
                HStack(){
                    Text("¿No tienes una cuentas?").font(.caption).foregroundColor(.gray)
                    Button("Registrarse"){
                        
                    }.font(.caption).foregroundColor(.black)
                }
                
            }
            .padding().simpleToast(isPresented: $showToast, options: toastOptions) {
                Label("Debe llenar todos los campos", systemImage: "exclamationmark.triangle")
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
            }
        
        
    }
}

#Preview {
    LoginView()
}
