//
//  SearchViewController.swift
//  Weather Forecast
//
//  Created by 4steps on 03.05.23.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func setLocation(city: CityModel)
}

class SearchViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - vars/lets
    var viewModel = SearchViewModel()
    
    weak var delegate: SearchDelegate?

    //MARK: - lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateUI()
        
    }
    

    //MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - flow func
    
    private func updateUI() {
        view.backgroundColor = .clear
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        viewModel.reloadTablView = {[weak self] in
            guard let self = self else {return}
            self.searchTableView.reloadData()
        }
    }
    
    private func configureTableView() {
        searchTableView.register(UINib(nibName: SearchTableViewCell.id, bundle: nil),  forCellReuseIdentifier: SearchTableViewCell.id)
    }
}

//MARK: - Extensions
// Search delegate
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchCity(text: text)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCity(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCity(text: searchBar.text!)
        self.searchBar.endEditing(true)
    }
}

// TableView delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        if viewModel.filteredCityIsEmpty() {
            return UITableViewCell()
            
        } else {
            
            guard let searchCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            searchCell.setupContent(model: viewModel.filteredCities[indexPath.row])
            return searchCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !viewModel.filteredCities.isEmpty
        {
            let selectedCity = viewModel.filteredCities[indexPath.row]
            self.delegate?.setLocation(city: selectedCity)
            self.dismiss(animated: true)
        }
    }
}

