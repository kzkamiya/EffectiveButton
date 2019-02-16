//
//  RoundButton.swift
//  RoundButton
//
//  Created by me on 2019/02/17.
//  Copyright © 2019 Neosystem. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class EffectiveButton: UIButton {
    
    enum SystemSound: UInt32 {
        
        case pressClick    = 1123
        case pressDelete   = 1155
        case pressModifier = 1156
        
        func play() {
            AudioServicesPlaySystemSound(self.rawValue)
        }
        
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var backgroundImageColor: UIColor =
        UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
        didSet {
            refreshColor(color: backgroundImageColor)
        }
    }
    
    func createImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    func refreshColor(color: UIColor) {
        let image = createImage(color: color)
        setBackgroundImage(image, for: UIControl.State.normal)
        clipsToBounds = true
    }

    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorder(borderWidth: borderWidth)
        }
    }
    
    func refreshBorder(borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }
    
    @IBInspectable var customBorderColor: UIColor = UIColor.init (red: 0, green: 122/255, blue: 255/255, alpha: 1){
        didSet {
            refreshBorderColor(colorBorder: customBorderColor)
        }
    }
    
    func refreshBorderColor(colorBorder: UIColor) {
        layer.borderColor = colorBorder.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshColor(color: backgroundImageColor)
        refreshBorderColor(colorBorder: customBorderColor)
        refreshBorder(borderWidth: borderWidth)
        self.tintColor = UIColor.white
        self.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func buttonEvent(_ sender: UIButton) {
        print("ボタンの情報: \(sender)")
        
         SystemSound.pressClick.play()
        
        // ボタンを押したことが、はっきりわかるように、ボタンの大きさを変化させます。
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )

        
    }
    
}
