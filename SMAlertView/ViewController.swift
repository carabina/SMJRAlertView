//
//  ViewController.swift
//  SMAlertBaseView
//
//  Created by KING on 2016/12/28.
//  Copyright © 2016年 KING. All rights reserved.
//

import UIKit

class KK: UIAlertView {
 
    deinit {
        
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alert("here", msg: "where do you want to go?", buttons: ["BeiJing", "HangZhou", "ShangHai"]) { (alertView) in
            debugPrint("go to BeiJing")
        }, { (alertView) in
            debugPrint("go to HangZhou")
        }, { (alertView) in
            debugPrint("go to ShangHai")
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0...2 {
            SMAlertView.init(title: "title: \(i)", message: nil, cancelButtonTitle: "cancel").show()
        }
    }

    
    @IBAction func sysMsg(_ sender: Any) {
        UIAlertView.init(title: "title", message: "为哈市的放假哈肯定会发卡机谁都为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假肯定会发卡机谁都会发的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假肯定会发卡机谁都会发生地方哈看的积分为会发生地方哈看的积分会发生地方哈看的积分", delegate: nil, cancelButtonTitle: "cancel").show()
    }
    
    @IBAction func smMsg(_ sender: Any) {
        SMAlertView.init(title: "title", message: "为哈市的放假哈肯定会发卡机谁都为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假肯定会发卡机谁都会发的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假肯定会发卡机谁都会发生地方哈看的积分为会发生地方哈看的积分会发生地方哈看的积分", cancelButtonTitle: "cancel").show()
    }
    
    @IBAction func titleCancel(_ sender: Any) {
        SMAlertView.init(title: "title", message: nil, cancelButtonTitle: "cancel").show()
    }
    
    @IBAction func message(_ sender: Any) {
        
//        Alert("new", msg: "custom", cancel: "cancel", buttons: ["afsadf","afsadf","afsadf"], click: {(alertView) in
//            print("0")
//            }, nil,{(alertView) in
//                print("2")
//        }).setWillDismiss ({ (index, alertView) in
//            
//        }).setDidDismiss { (index, alertView) in
//            
//        }
        
        SMAlertView.init(title: nil, message: "message", cancelButtonTitle: "取消").show()
    }
    
    @IBAction func title_image(_ sender: Any) {
        
        SMAlertImageView.init(title: "title", message: nil, image: UIImage.init(named: "icon"), delegate: nil, cancelButtonTitle: "cancel", OB: ["first"]).show()
    }
    
    
    @IBAction func message_image(_ sender: Any) {
        SMAlertImageView.init(title: "哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假肯定会发卡机谁都会发的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈为哈市的放假哈肯定会发卡机谁都会发生地方哈看的积分为哈市的放假哈肯", message: nil, image: UIImage.init(named: "icon"), delegate: nil, cancelButtonTitle: "cancel", OB: ["first"]).show()
    }
    
    
    @IBAction func title_message_image(_ sender: Any) {
        SMAlertImageView.init(title: "title", message: "message", image: UIImage.init(named: "icon"), delegate: self, cancelButtonTitle: "cancel", OB: ["first"]).show()
    }
    
    @IBAction func buttons(_ sender: Any) {
        
//        let view = SMAlertImageView.init(title: "title", message: "message", image: UIImage.init(named: "icon"), delegate: self, cancelButtonTitle: "cancel", OB: ["first", "second"])
        
        let view = SMAlertView.init(title: "title", message: "message", cancelButtonTitle: "cancel", destructive: "destructive", OB: ["other1", "other2"], delegate: nil)
        
//        let view = SMAlertView.init(title: "title", message: "message", cancelButtonTitle: "cancel", destructive: "destructive", OB: nil, delegate: nil)
        
        view.addButton(SMAlertButton.SMAlertButtonType.destructive) { (button) in
            button.button.setTitle("关键", for: .normal)
        }
        view.addButton(SMAlertButton.SMAlertButtonType.default) { (button) in
            button.button.setTitle("新增", for: .normal)
        }
        view.show()
    }
    
    @IBAction func attText(_ sender: Any) {
        
        let att = NSMutableAttributedString()
        
        let f = NSAttributedString.init(string: "可通过一下方式提高：\n", attributes: [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14)
            ])
        
        let s = NSAttributedString.init(string: "①. 确保光线充足\n", attributes: [
            NSForegroundColorAttributeName: UIColor.blue,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14)
            ])
        
        let t = NSAttributedString.init(string: "②. 摘掉眼镜，并漏出耳朵\n", attributes: [
            NSForegroundColorAttributeName: UIColor.blue,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14)
            ])
        
        let ff = NSAttributedString.init(string: "③. 正确的脸型动作", attributes: [
            NSForegroundColorAttributeName: UIColor.blue,
            NSFontAttributeName: UIFont.systemFont(ofSize: 14)
            ])
        
        att.append(f)
        att.append(s)
        att.append(t)
        att.append(ff)
        
        let view = SMAlertImageView.init(title: "验证失败", attributeMessage: att, image: UIImage.init(named: "22"), cancelButtonTitle: "返回", destructive: "从新认证", OB: nil, delegate: nil)
        
        view.show()
     
    }
    
}


extension ViewController : SMAlertViewDelegate {
    
    func alterViewConfig(_ alterView: SMAlertView, messageLabel: SMAlertLabel) {
        
        // messageLabel.label.textAlignment = .center
        
        // messageLabel.contentInset.left = 60
        
        // messageLabel.contentInset.right = 60
    }
    
    func alterViewConfig(_ alterView: SMAlertView, button: SMAlertButton, index: Int) {
        button.button.setTitleColor(UIColor.red, for: .normal)
    }
}
