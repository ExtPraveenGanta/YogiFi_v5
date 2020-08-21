//
//  YogifiStatusScreen.swift
//  YogiFi
//
//  Created by NFCIndia on 20/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import UIKit
import CenteredCollectionView


class YogifiStatusScreen: UIViewController, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollBarView: UIView!
    @IBOutlet weak var scrollBarBtn: UIButton!
    
    var topLabels = ["","#letsGetYogiFied",""]
    var bottomLabels = [NSAttributedString]()
    var btnColors = [UIColor]()
    var btntitles = ["let's go!","take me to buy now!","Practice with YogiFi vision"]
    let attStrings = ["oh! Yes!\nI own a\nYogiFi Smart \nMat!","how do\ni order my\nYogifi smart mat?","i\'ll try \nthe free\nyogifi vision \nexperience"]
    
    let cellPercentWidth: CGFloat = 0.8
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the reference to the CenteredCollectionViewFlowLayout (REQURED)
        centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        
        // Modify the collectionView's decelerationRate (REQURED)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        // Configure the required item size (REQURED)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: view.bounds.width * cellPercentWidth,
            height: view.bounds.height * cellPercentWidth * cellPercentWidth
        )
        
        // Configure the optional inter item spacing (OPTIONAL)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 10
        
        
        let attributedString1 = NSMutableAttributedString(string:attStrings[0].uppercased(), attributes: [
            .font: UIFont(name: "NotoSans-BoldItalic", size: 25.0)!,
            .foregroundColor: UIColor.aqua,
            .kern: 0.5
        ])
        attributedString1.addAttribute(.foregroundColor, value: UIColor.whiteTwo, range: NSRange(location: 0, length: 17))
        
        let attributedString2 = NSMutableAttributedString(string:attStrings[1].uppercased(), attributes: [
            .font: UIFont(name: "NotoSans-BoldItalic", size: 25.0)!,
            .foregroundColor: UIColor.whiteTwo,
            .kern: 0.5
        ])
        attributedString2.addAttribute(.foregroundColor, value: UIColor.azure, range: NSRange(location: 18, length: 17))
        
        
        let attributedString3 = NSMutableAttributedString(string:attStrings[2].uppercased(), attributes: [
            .font: UIFont(name: "NotoSans-BoldItalic", size: 25.0)!,
            .foregroundColor: UIColor.tangerine,
            .kern: 0.5
        ])
        attributedString3.addAttribute(.foregroundColor, value: UIColor.whiteTwo, range: NSRange(location: 0, length: 19))
        bottomLabels.append(attributedString1)
        bottomLabels.append(attributedString2)
        bottomLabels.append(attributedString3)
        
        btnColors = [.aqua,.azure,.tangerine]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! YogifiStatusCell
        cell.topLbl.text = topLabels[indexPath.item]
        cell.bottomColorLbl.attributedText = bottomLabels[indexPath.item]
        cell.btnView.backgroundColor = btnColors[indexPath.item]
        cell.buyBtn.setTitle(btntitles[indexPath.item].uppercased(), for:.normal)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
    }
    
    @IBAction func colView_btn_action(_ sender: Any) {
        
    }
}

extension YogifiStatusScreen: UICollectionViewDelegateFlowLayout {
    
}
