//
//  ReservationViewController.swift
//  MealsBooking
//
//  Created by Anis on 5/9/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Alamofire

class ReservationViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
     let  url = "http://mealsbooking.online/api/reservation"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var nbPersonTF: UITextField!
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
        let userParametre = ["name" : "test5" , "nbperson" : nbPersonTF.text!, "time" : "\(dateLabel.text!) \(timeLabel.text!)","approved" : "0","user_id": "1","restaurant_id": "1"]

        
        Alamofire.request(url, method: .post, parameters: userParametre, encoding: JSONEncoding.default )
            .responseJSON { (response) in
                
                switch(response.result)
                {
                case .success( _):
                      ProgressHUD.showSuccess("Success !", interaction: true)
                     self.dismiss(animated: true, completion:nil)
                    
                case .failure(_):
                    ProgressHUD.showError("Wrong credantials", interaction: true)
                    
                }
                
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    

    var theme: SambagTheme = .light
  
    @IBAction func showSambagTimePickerViewController(_ sender: UIButton) {
        let vc = SambagTimePickerViewController()
        vc.theme = theme
        vc.delegate = self as SambagTimePickerViewControllerDelegate
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func showSambagDatePickerViewController(_ sender: UIButton) {
        let vc = SambagDatePickerViewController()
        vc.theme = theme
        vc.delegate = self as SambagDatePickerViewControllerDelegate
        present(vc, animated: true, completion: nil)
        
    }
    

}

extension ReservationViewController: SambagTimePickerViewControllerDelegate {
    
    func sambagTimePickerDidSet(_ viewController: SambagTimePickerViewController, result: SambagTimePickerResult) {
        timeLabel.text = "\(result)"
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagTimePickerDidCancel(_ viewController: SambagTimePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}


extension ReservationViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
        dateLabel.text = "\(result)"
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
