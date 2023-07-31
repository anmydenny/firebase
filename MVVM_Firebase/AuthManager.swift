//
//  AuthManager.swift
//  MVVM_Firebase
//
//  Created by ANMY DENNY on 25/07/23.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private var verificationId: String?
    
    public func startAuth(phone: String , completion: @escaping (Bool) -> Void) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId , error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    public func verifyOtp(otp: String , completion: @escaping (Bool) -> Void) {
        
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otp)
        auth.signIn(with: credential)
        {
            result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
