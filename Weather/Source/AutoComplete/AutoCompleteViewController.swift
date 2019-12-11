//
//  AutoCompleteViewController.swift
//  Weather
//
//  Created by Arslan Faisal on 29/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController {

    @IBOutlet weak var autoCompleteTblView: UITableView!
    lazy var viewModel = AutoCompleteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
    }
    func bindVM() {
        viewModel.cities.bind({ [weak self] _ in
            DispatchQueue.main.async {
                self?.autoCompleteTblView.reloadData()
            }
        })
    }
}
//MARK:- TableView Delegate and DataSource
extension AutoCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.autoCompleteCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifiers.autoCompleteCellIdentifier)
        }
        cell.textLabel?.text = viewModel.predictionText(indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let city = viewModel.cityAtIndex(indexPath.row) else { return }
        // When user selects on a city, its set in the autocompolete view model *cityToSearch* which triggers search call through *WeatherViewModel* class
        viewModel.cityToSearch.value = city
    }
    
}
