//
//  OtpVC.swift
//  MVVM_Firebase
//
//  Created by ANMY DENNY on 25/07/23.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet weak var tfOtp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func verifyBtn(_ sender: Any) {
        AuthManager.shared.verifyOtp(otp: tfOtp.text ?? "") { status in
            if (status) {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let UserDetailsVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC
                self.present(UserDetailsVC, animated:true, completion:nil)
            } else {
                print("error")
            }
        }
    }
}
