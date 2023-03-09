//
//  ViewController.swift
//  lesson 3 animations
//
//  Created by Константин Лопаткин on 09.03.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    var size: CGFloat = 100
    lazy var rectangle = UIView()
    let animationView = UIView()
    let slider: MySlider = .init(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.addSubview(mainView)
        rectangle.frame = CGRect(x: 0, y: 50, width: size, height: size)
        
        rectangle.layer.backgroundColor = UIColor.blue.cgColor
        rectangle.layer.cornerRadius = 16
       
//        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .cyan
        animationView.addSubview(rectangle)
        

        
        slider.minimumValue = 0
        slider.maximumValue = Float(UIScreen.main.bounds.width)
        slider.tintColor = .green
        slider.isContinuous = true
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        view.addSubview(slider)
        
        animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        slider.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 200).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        view.updateConstraints()
        slider.addTarget(self, action: #selector(changeSlider), for: [.valueChanged, .allEvents])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: self.view.layoutMargins.top,
            leading: 16,
            bottom: self.view.directionalLayoutMargins.bottom,
            trailing: 16)
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    override func viewLayoutMarginsDidChange() {
     super.viewLayoutMarginsDidChange()
     
    }
    
    @objc func changeSlider(_ slider: UISlider, event: UIEvent) {
        
        let max = Float(UIScreen.main.bounds.width / 3)
        let current = abs(slider.value)
        let persistage = current / max
        let returned = 0.14 + persistage

        if let touch = event.allTouches?.first {
            switch touch.phase {
            case .ended:
                slider.value = slider.maximumValue
            default:
                break
            }
        }
        let rotation = CGAffineTransform(rotationAngle: CGFloat(returned / 2))
        
        let scaled = rotation.scaledBy(x: CGFloat(1 + returned / 6), y: CGFloat(1 + returned / 6))
        
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.layoutSubviews, .beginFromCurrentState]) {
            self.rectangle.transform = scaled
            self.rectangle.center.x = CGFloat(50 + CGFloat(returned) * 75)
        } completion: { (res) in
            
        }
    }

}
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ViewController()
        }
    }
}

class MySlider: UISlider {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
//        self.setValue(maximumValue, animated: true)
    }
}
