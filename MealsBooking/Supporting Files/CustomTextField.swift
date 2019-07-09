//
//  CustomTextField.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/16/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
class CustomTextField: UITextField {
    
    convenience init() {
        self.init(frame: .zero)
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    var change: Bool = false {
        didSet {
            textColor = change ? .yellow : .black
            backgroundColor = change ? .blue : .white
        }
    }
    
}
