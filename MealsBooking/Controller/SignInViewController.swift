//
//  SignInViewController.swift
//  MealsBooking
//
//  Created by Sim1718 on 4/19/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Alamofire
import TransitionButton
import FBSDKLoginKit
import GoogleSignIn




class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate  {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error)
            performSegue(withIdentifier: "HomeViewController", sender: self)
            return
        }
        
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "Signed in user:\n\(fullName)"])
        // [END_EXCLUDE]
    
        print(user.profile.email)
        print(user.profile.imageURL(withDimension: 400))
        performSegue(withIdentifier: "HomeViewController", sender: self)
        
        
        
    }
    
    

  
    
    
    
    
    let  url = "http://mealsbooking.online/api/login"

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var fbButton: FBSDKLoginButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         GIDSignIn.sharedInstance().uiDelegate = self
        
//        fbButton.layer.cornerRadius = fbButton.sizeThatFits(<#T##size: CGSize##CGSize#>)/2
//        fbButton.layer.masksToBounds = true
//        //fbButton.layer.borderColor = UIColor.blackColor().CGColor
//        fbButton.layer.borderWidth = 2
   
//
//            let loginButton = FBSDKLoginButton()
//            loginButton.center = view.center
//        view.addSubview(loginButton)

        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        

        

//        if FBSDKAccessToken.currentAccessTokenIsActive(){
//            fetchProfile()
//        }
//
//
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        self.performSegue(withIdentifier: "create", sender: nil)
    }
    
    
    @IBAction func signInButton(_ sender: TransitionButton) {
        
        let userParametre = ["username" : usernameTF.text! , "password" : passwordTF.text!]
        
       
 
        
        sender.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                
                Alamofire.request(self.url, method: .post, parameters: userParametre, encoding: JSONEncoding.default )
                    .responseJSON { (response:DataResponse) in
                        
                        switch(response.result)
                        {
                        case .success(let value):

                            
                            sender.stopAnimation(animationStyle: .expand, completion: {
                                guard let json = value as? [String: Any] else {
                                    return
                                }
                                let token = json["access_token"]
                                UserDefaults.standard.set(token, forKey: "token")
                                self.performSegue(withIdentifier: "HomeViewController", sender: Any?.self)

                            })
                            
                        case .failure(_):
                            sender.stopAnimation(animationStyle: .shake, completion: {
                                  ProgressHUD.showError("Wrong credantials", interaction: true)
                            })
                        }
                }
              
           
            })
        })
        
    }
    

    
    
    @IBAction func backButton(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }

    func fetchProfile() {
        print("fetch profile")
        let parameters = ["fields": "email, first_name, last_name"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters)?.start(completionHandler: { (connection, result, error) in
            if ((error) != nil) {
                // Process error
            }

            else {
                self.performSegue(withIdentifier: "HomeViewController", sender: nil)
            }

        })

    }


    @IBAction func fbLoginAction(_ sender: FBSDKLoginButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    self.performSegue(withIdentifier: "HomeViewController", sender: nil)
                    
                }
            })
        }
    }
    

    
    @IBAction func googleSignIn(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance()?.signIn()
        self.performSegue(withIdentifier: "HomeViewController", sender: nil)
     //   signIn(signIn: GIDSignIn?, didSignInForUser: GIDGoogleUser?, withError: NSError?)
        
    }
    
    
    
  
    
 
    
}
