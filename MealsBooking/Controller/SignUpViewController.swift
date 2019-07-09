//
//  SignUpViewController.swift
//  MealsBooking
//
//  Created by Sim1718 on 4/19/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    let  url = "http://mealsbooking.online/api/register"

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "login", sender: nil)
    }
    
    @IBAction func signin(_ sender: UIButton) {
        let userParametre = ["name" : name.text! , "email" : email.text!, "password" : password.text!]
        
        
        Alamofire.request(url, method: .post, parameters: userParametre, encoding: JSONEncoding.default )
            .responseJSON { (response) in
                
                switch(response.result)
                {
                case .success(let value):
                    
                    guard let json = value as? [String: Any] else {
                        return
                    }
                    let token = json["access_token"]
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                    
                    
                case .failure(_):
                    
                    ProgressHUD.showError("Wrong credantials", interaction: true)
                    
                }
                
        }
        
        
    }
    
}
