//
//  AuthenticationModel.swift
//  CourseEnrollHub
//
//  Created by Teja Kumar Muppala on 3/4/24.
//

import FirebaseAuth


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func createUser(name: String, email: String, password: String, completion: @escaping (Error?, Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password)  { authResult, error in
            
            let profile = authResult?.user.createProfileChangeRequest()
            profile?.displayName = name
            profile?.commitChanges(completion: { error in
                if error != nil {
                    
                    completion(error, false)
                }else{
                    
                    completion(nil, true)
                }
            })
        }
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Error?, Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                
                completion(error, false)
            }else{
                
                completion(nil, true)
            }
        }
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    func resetPassword(email :String, completion: @escaping (Error?, Bool) -> ()){
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            
            if error != nil {
                
                completion(error, false)
            }else{
                
                completion(nil, true)
            }
        }
    }
    
    func deleteUser(){
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error while trying to delete user - \(error.localizedDescription)")
            } else {
                print("Success! User deleted.")
            }
        }
    }
}

