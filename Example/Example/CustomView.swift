//
//  CustomView.swift
//  Example
//
//  Created by 刘鹏i on 2019/1/8.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBOutlet internal var btnClose: UIButton!
    @IBOutlet internal var label: UILabel!
    
    internal var closeBlock: (() -> Void)?
    
    
    
    @IBAction func closeAction(_ sender: Any) {
        closeBlock?()
    }
    
    deinit {
        print("\(self) 销毁了!")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
