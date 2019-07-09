//
//  ViewController.swift
//  MealsBooking
//
//  Created by Sim1718 on 4/18/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import TransitionButton


class ViewController: UIViewController {

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   
  

  
    @IBAction func SignUp(_ sender: UIButton) {
        
        performSegue(withIdentifier: "signUp", sender: Any?.self)
    }
    
    @IBAction func signIn(_ sender: TransitionButton) {
        sender.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                sender.stopAnimation(animationStyle: .expand, completion: {
//                 self.performSegue(withIdentifier: "signIn", sender: Any?.self)
                    let secondVC = SignInViewController()
                    self.present(secondVC, animated: true, completion: nil)
                    
                })
            })
        })
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "signIn" {
            let destinationVC = segue.destination as! SignInViewController
        }
        else if segue.identifier == "signUn" {
            
            let destinationVC = segue.destination as! SignUpViewController
        }
     
            
        }
    
    
    
      
    
    
    
    
    
    
    }
    

  
    
    
    


