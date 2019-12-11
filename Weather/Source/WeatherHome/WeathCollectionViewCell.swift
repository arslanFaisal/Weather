//
//  WeathCollectionViewCell.swift
//  Weather
//
//  Created by Arslan Faisal on 28/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class WeathCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    
    lazy var viewModel = WeatherCollectionCellViewModel()
    
    override func awakeFromNib() {
        resetView()
    }
    override func prepareForReuse() {
       resetView()
    }
    
    /// Binds ViewModel listenser for setting cell icon and call method for fetching image icon
    func bindVM() {
        viewModel.weatherIconImg.bind({ [weak self] image in
            DispatchQueue.main.async {
                self?.weatherImgView.image = image
            }
        })
        viewModel.fetchIcon()
    }
    
    /// Sets default empty or nil values for all the properties
    func resetView(){
        timeLabel.text = ""
        tempratureLabel.text = ""
        weatherImgView.image = nil
    }

    /// Sets values for all properties and bind ViewModel
    func setupCell() {
        bindVM()
        tempratureLabel.text = viewModel.forcastTemprature
        timeLabel.text = viewModel.forcastTime
    }
}
