//
//  ViewController.swift
//  MVVM_Firebase
//
//  Created by ANMY DENNY on 25/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var phoneTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }


    @IBAction func loginAction(_ sender: Any) {
        if let phNo = phoneTF.text{
            if validate(value: phNo) || !(phNo.isEmpty) {
                AuthManager.shared.startAuth(phone: phNo) { status in
                    if status {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let OtpVC = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                        self.present(OtpVC, animated:true, completion:nil)
                    } else {
                        
                    }
                }
            } else {
                self.showToast(message: "Invalid mobile number", font: .systemFont(ofSize: 12.0))
            }
        }
    }
}

extension ViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
