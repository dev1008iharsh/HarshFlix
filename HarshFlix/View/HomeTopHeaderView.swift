//
//  TopHeaderView.swift
//  Harshflix
//
//  Created by My Mac Mini on 19/12/23.
//

import UIKit

//MARK: -  Used on Home TabBar
class HomeTopHeaderView: UIView {
    /*
     private let downloadButton: UIButton = {
     let button = UIButton()

     button.translatesAutoresizingMaskIntoConstraints = false
     button.layer.cornerRadius = 10
     return button
     }()*/
    
    private let imgHeaderTopHome: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        
        setColorsOfGradient(gradient : gradientLayer)
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
    
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    // mananging dark mode light mode
    func setColorsOfGradient(gradient : CAGradientLayer){
        if self.traitCollection.userInterfaceStyle == .light {
            gradient.colors = [UIKit.UIColor.clear.cgColor,UIKit.UIColor.systemBackground.cgColor]
        } else {
            gradient.colors = [UIKit.UIColor.clear.cgColor,UIKit.UIColor.black.cgColor]
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgHeaderTopHome)
        addGradient()
        //addSubview(playButton)
        //addSubview(downloadButton)
        //applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgHeaderTopHome.frame = bounds
    }
   (with: url)
        
    }
    
    
    /*
     func applyConstraints(){
     let playButtonConstraints = [
     playButton.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 20),
     playButton.bottomAnchor.constraint (equalTo: bottomAnchor, constant: -50),
     playButton.widthAnchor.constraint (equalToConstant: 100)
     
     }*/
    
    
}
