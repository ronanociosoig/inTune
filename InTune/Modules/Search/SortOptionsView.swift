//
//  SortOptionsView.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

class SortOptionsView: UIView {
    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.white
        segmentedView.isUserInteractionEnabled = true
        
        segmentedView.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
    }
    
    @objc func segmentDidChange(_ sender: Any) {
        
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        print("Value changed: \(selectedIndex)")
        
    }
}

