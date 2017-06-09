//
//  SMAlertButtonsView.swift
//  SMAlertView
//
//  Created by 王铁山 on 2017/5/21.
//  Copyright © 2017年 KING. All rights reserved.
//

import Foundation

import UIKit

public protocol SMAlertButtonsViewDelegate: NSObjectProtocol {
    
    func alterViewClickButton(_ alterView: SMAlertButtonsView, buttonIndex: Int)
    
    func alterViewConfig(_ alterView: SMAlertButtonsView, button: SMAlertButton, index: Int)
}

open class SMAlertButtonsView: UIView {
    
    open weak var delegate: SMAlertButtonsViewDelegate?

    /// 存放按钮
    private var buttons: [SMAlertButton] = [SMAlertButton]()
    
    /// 每行最多的按钮数
    open var maxBtnRow = 2
    
    /// 每个按钮的高度
    open var buttonRowHeight: CGFloat = 44
    
    open func buttonsHeight() -> CGFloat {
        return self.buttons.count == 0 ? 0 : self.buttons.last!.frame.maxY
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutButtons()
    }
 
    public final func addButton(_ alterType: SMAlertButton.SMAlertButtonType) {
        self.addButton(alterType, configue: nil)
    }
    
    public final func addButton(_ alterType: SMAlertButton.SMAlertButtonType, configue: ((SMAlertButton)->Void)?) {
        SMAlertCheckMainThread()
        let btn = SMAlertButton.init(alterType: alterType)
        btn.s_tag = self.currentTag
        self.currentTag += 1
        self.buttons.append(btn)
        self.addSubview(btn)
        btn.touchUpInsideAction = { [weak self] (alertButton) in
            self?.buttonClick(alertButton)
        }
        
        configue?(btn)
    
        delegate?.alterViewConfig(self, button: btn, index: self.currentTag - self.SMAlertViewBaseTag)
    }
    
    private func buttonClick(_ button: SMAlertButton) {
        
        delegate?.alterViewClickButton(self, buttonIndex: button.s_tag - self.SMAlertViewBaseTag)
    }
    
    private func layoutButtons() {
        
        let count = self.buttons.count
        
        if count == 0 { return }
        
        let f_count: CGFloat = CGFloat(self.buttons.count)
        
        let superWidth = self.frame.size.width
        
        if count <= self.maxBtnRow && count > 0 {
            
            let Y: CGFloat = 0
            var X: CGFloat = 0
            let width: CGFloat = superWidth / f_count
            let height = self.buttonRowHeight
            
            for i in 0..<count {
                
                let btn = self.buttons[i]
                
                X = CGFloat(i) * width
                
                btn.frame = CGRect(x: X, y: Y, width: width, height: height)
                
                btn.setLineViewTop()
                
                if i != count - 1 {
                    btn.setLineViewRight()
                }
            }
            
        } else {
            
            var Y: CGFloat = 0
            let X: CGFloat = 0
            let width: CGFloat = superWidth
            let height = self.buttonRowHeight
            
            for i in 0..<count {
                
                Y = CGFloat(i) * height
                
                let btn = self.buttons[i]
                
                btn.frame = CGRect(x: X, y: Y, width: width, height: height)
                
                btn.setLineViewTop()
            }
            
        }
        
        self.bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.buttonsHeight())
    }
    
    private var SMAlertViewBaseTag: Int = 1000
    
    private var currentTag = 1000
    
    
}
