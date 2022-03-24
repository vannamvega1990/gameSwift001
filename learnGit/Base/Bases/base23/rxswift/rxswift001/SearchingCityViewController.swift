//
//  SearchingCityViewController.swift
//  learnGit
//
//  Created by THONG TRAN on 23/03/2022.
//

import UIKit
import RxCocoa
import RxSwift

class SearchingCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    init() {
        super.init(nibName: "SearchingCityViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["Oklahoma", "Chicago", "Moscow", "Danang", "Vancouver", "Praga"] // Mocked API data source

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        searchBar
            .rx.text // Observable property
            .orEmpty // Make it non-optional
            .debounce(DispatchTimeInterval.milliseconds(96), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.tableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)

        
        

        // Do any additional setup after loading the view.
    }



}
