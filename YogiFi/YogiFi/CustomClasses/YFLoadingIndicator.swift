//
//  YFLoadingIndicator.swift
//  YogiFi
//
//  Created by NFCIndia on 18/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation
import Lottie

class YFLoadingIndicator: UIView {
    //MARK:- Properties
    //MARK: Variables
    var animationView: AnimationView?
    //MARK: Constants
    let animationViewWidth: CGFloat = 160
    let animationViewHeight: CGFloat = 160
    
    //MARK:- Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.blackFour.withAlphaComponent(0.75)
        self.isOpaque = false
        loadAnimationView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience init(view: UIView)
    {
        self.init(frame: view.bounds)
    }
}

//MARK:- Load Animation View
private extension YFLoadingIndicator
{
    func loadAnimationView()
    {
        if(animationView != nil)
        {
            animationView!.removeFromSuperview()
        }
        self.initializeAnimationView()
        animationView!.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    func initializeAnimationView()
    {
        animationView = AnimationView()
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        animationView!.backgroundColor = UIColor.clear
        
        let animation = Animation.named("Loaderanimation")
        animationView!.animation = animation
        
        animationView!.contentMode = .scaleAspectFill
        animationView!.backgroundBehavior = .pauseAndRestore
        self.addSubview(animationView!)
        animationView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView!.widthAnchor.constraint(equalToConstant: animationViewWidth).isActive = true
        animationView!.heightAnchor.constraint(equalToConstant: animationViewHeight).isActive = true
    }
    
    func hideAnimationView()
    {
        if let aView = self.animationView
        {
            aView.stop()
            aView.removeFromSuperview()
        }
    }
}


//MARK:- Indicator View Private Method
private extension YFLoadingIndicator
{
    static func loadingIndicator(forView view:UIView) -> YFLoadingIndicator?
    {
        let subViews:[UIView] = view.subviews.reversed()
        var view:YFLoadingIndicator?
        for subView in subViews
        {
            if subView is YFLoadingIndicator
            {
                view = subView as? YFLoadingIndicator
            }
        }
        return view
    }
    
    static func allLoadingIndicator(forView view:UIView) -> [YFLoadingIndicator]
    {
        var indicators:[YFLoadingIndicator] = [YFLoadingIndicator]()
        let subViews:[UIView] = view.subviews.reversed()
        for subView in subViews
        {
            if subView is YFLoadingIndicator
            {
                if let view = subView as? YFLoadingIndicator
                {
                    indicators.append(view)
                }
            }
        }
        return indicators
    }
    
    static func endIgnoringInteractions()
    {
        if (UIApplication.shared.isIgnoringInteractionEvents)
        {
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
 
    static func startIgnoringInteractions()
    {
        if (!UIApplication.shared.isIgnoringInteractionEvents)
        {
            DispatchQueue.main.async {
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
        }
    }
}


//MARK:- Hide/Show Loading Indicator
extension YFLoadingIndicator
{
    static func show(view: UIView)
    {
        if loadingIndicator(forView: view) == nil
        {
            let indicator = YFLoadingIndicator.init(view: view)
            DispatchQueue.main.async {
                view.addSubview(indicator)
            }
            startIgnoringInteractions()
        }
    }
    
    static func hide(view: UIView)
    {
        if let indicatorView = loadingIndicator(forView: view)
        {
            endIgnoringInteractions()
            DispatchQueue.main.async {
                indicatorView.hideAnimationView()
                indicatorView.removeFromSuperview()
            }
        }
    }
    
    static func hideAll(view: UIView)
    {
        for indicatorView in allLoadingIndicator(forView: view)
        {
            endIgnoringInteractions()
            DispatchQueue.main.async {
                indicatorView.hideAnimationView()
                indicatorView.removeFromSuperview()
            }
        }
    }
}

