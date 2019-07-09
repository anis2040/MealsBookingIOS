//
//  EditProfileViewController.swift
//  MealsBooking
//
//  Created by Anis on 5/2/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func editProfile(_ sender: UIButton) {
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
          self.dismiss(animated: true, completion:nil)
    }
    



}
