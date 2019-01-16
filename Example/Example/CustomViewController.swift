//
//  CustomViewController.swift
//  Example
//
//  Created by 刘鹏i on 2019/1/8.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    @IBOutlet internal var btnClose: UIButton!
    @IBOutlet internal var label: UILabel!
    
    internal var closeBlock: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closeAction(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: {
            self.closeBlock?()
        })
    }
    
    deinit {
        print("\(self) 销毁了!")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
