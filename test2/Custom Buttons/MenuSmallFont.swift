//
//  CustomB2.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/13/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit

class CustomB2: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton(){
        setShadow()
        style()
        
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius  = 6
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    private func style(){
        setTitleColor(.white, for: .normal)
        //backgroundColor     = #colorLiteral(red: 0.2382456701, green: 0.6202785326, blue: 0.05774857673, alpha: 1)
        backgroundColor     = #colorLiteral(red: 0.2542191711, green: 0.4708681398, blue: 0.7095618207, alpha: 1)
        layer.cornerRadius  = 20
        titleLabel?.font    = UIFont(name: "AvenirNext-DemiBold", size: 16)
    }

}
