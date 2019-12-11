//
//  ViewController.swift
//  Weather
//
//  Created by Arslan Faisal on 27/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var autoCompleteContainer: UIView!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    
    private lazy var viewModel = WeatherViewModel()
    private var collectionComposition = CollectionComposition()
    
    /// Called for hiding container view with autocompletion when user taps on a city name
    fileprivate lazy var hideAutoComplete = { [weak self] in
        DispatchQueue.main.async {
            self?.cityTxtField.resignFirstResponder()
            self?.cityTxtField.text = ""
            self?.autoCompleteContainer.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Live Weather"
        weatherCollectionView.collectionViewLayout = collectionComposition.setupCollectionLayout()
        bindVM()
    }
    @IBAction func dataTypeSegmentChanged(_ sender: Any) {
        guard let segmentControl = sender as? UISegmentedControl else { return }
        //Show/hide text field based on segment selection, for offline weather search field is hidden
        if segmentControl.selectedSegmentIndex == 0 {
            viewModel.viewType.value = .live
            textFieldHeightConstraint.constant = Constraints.textFieldHeight
        }else {
            viewModel.viewType.value = .offline
            textFieldHeightConstraint.constant = CGFloat(0.0)
        }
        //Changing title of view based on segment selection and hiding autocomplete container
        DispatchQueue.main.async { [weak self] in
            self?.title = self?.viewModel.titleForView()
            self?.hideAutoComplete()
        }
    }
}
//MARK:- Initialize view model
extension WeatherViewController: AlertService {
    
    /// Binds ViewModel dateWiseForcastArray  listenser for reloading data on data fetch and call method for fetching weather for default city on app launch
    func bindVM() {
        viewModel.dateWiseForcastArray.bind({ [weak self] _ in
                DispatchQueue.main.async {
                    self?.title = self?.viewModel.titleForView()
                    self?.weatherCollectionView.reloadData()
                }
        })
        viewModel.dataFetchErrorString.bind { [weak self] errorString in
            DispatchQueue.main.async {
                self?.showAlert(titleStr: "Error", messageStr: errorString, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
            }

        }
        viewModel.hideAutoCompleteView = hideAutoComplete
        viewModel.fetchWeatherForCity(WeatherAPIKey.defaultCity)
    }
}
//MARK:- Segue
extension WeatherViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //binding *WeatherViewModel* and *AutoCompleteViewModel* for communication between view models
        if segue.identifier == Segues.autoCompleteSegue {
            if let autoCompleteVC = segue.destination as? AutoCompleteViewController {
                viewModel.citySearchTerm.bind(autoCompleteVC.viewModel.searchLister)
                autoCompleteVC.viewModel.cityToSearch.bind(viewModel.autoSelectionLister)
            }
        }
    }
}
//MARK:- UItextField Delegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideAutoComplete()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            viewModel.citySearchTerm.value = updatedText
            if updatedText.count > SearchTerm.minimumSearchTermCharacters {
                autoCompleteContainer.isHidden = false
            }
        }
        return true
    }
}
//MARK:- CollectionView DataSource and Delegate
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.weatherCellIdentifier, for: indexPath) as! WeathCollectionViewCell
        let forcast = viewModel.forcastAtSection(indexPath.section, row: indexPath.row)
        cell.viewModel.forcast = forcast
        cell.setupCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         
        var reusableview = UICollectionReusableView()
        if (kind == UICollectionView.elementKindSectionHeader) {
            let dateHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifiers.weatherDateHeaderIdentifier, for: indexPath) as! DateHeaderCollectionReusableView
            dateHeader.setupHeader(viewModel.dateStringForSection(indexPath.section))
            reusableview = dateHeader
         }
         return reusableview
    }
}
