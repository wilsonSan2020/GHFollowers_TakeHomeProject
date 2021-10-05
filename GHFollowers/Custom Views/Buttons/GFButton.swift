//
//  GFButton.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/16/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    //subclass of UIButton we are overriding
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()

        //custom code
        //building on top of the UIButtton
    }
    
    required init?(coder: NSCoder) {
        //not using any storyboard but anyways need the init
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame : .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        //sets up cornerRadious, font, etc....
        configure()
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //to change color on the fly
    /*func set(backgroundColor : UIColor, title : String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }*/
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
