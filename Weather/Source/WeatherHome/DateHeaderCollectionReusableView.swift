//
//  DateHeaderCollectionReusableView.swift
//  Weather
//
//  Created by Arslan Faisal on 29/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class DateHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        resetView()
    }
    
    override func prepareForReuse() {
        resetView()
    }
    
    /// Sets default empty values for dateLabel
    func resetView() {
        dateLabel.text = ""
    }
    
    /// Sets value for all dateLabel
    /// - Parameter dateStr: Date string
    func setupHeader(_ dateStr: String) {
        dateLabel.text = dateStr
    }
}
