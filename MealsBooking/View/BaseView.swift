//
//  BaseView.swift
//  MealsBooking
//
//  Created by Anis on 5/8/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

@IBDesignable class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure()  {
        
    }
    
}
