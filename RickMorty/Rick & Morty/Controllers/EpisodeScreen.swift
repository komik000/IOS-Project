//
//  EpisodeScreen.swift
//  Rick & Morty
//
//  Created by Alisher Manatbek on 04.06.2023.
//

import UIKit

class EpisodeScreen: UIViewController {
    
    private var list: [ResultEp] = []
    let color = UIColor(named: "blue")
    let searchBarColor = UIColor(named: "searchBar")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        
        return tableView
    }()
    
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView(image : UIImage(named: "SearchIcon.png"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = color

        return searchIcon
    }()
    
    lazy var customView: UIView = {
        let customView = UIView()
        customView.addSubview(searchIcon)
        
        return customView
    }()
    
    
    lazy var searchBar : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Find Episode"
        textField.layer.cornerRadius = 20

        textField.textColor = UIColor(red: 175/255, green: 155/255, blue: 155/255, alpha: 1)
        textField.backgroundColor = searchBarColor

                
        textField.leftView = customView
        textField.leftViewMode = .always

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        searchBar.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier:  EpisodeTableViewCell.identifier)
        
        APIManager.shared.getDataEpisode { [weak self] values in
            DispatchQueue.main.async {
                guard let self = self else{return}
                self.list = values
                self.tableView.reloadData()
            }
        }
        
        UISetup()
        makeConstr()
    }
    
    
    func makeConstr() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        customView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        searchIcon.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    func UISetup() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
}

extension EpisodeScreen: UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell else {
            fatalError("Failed to dequeue CharacterTableViewCell")
        }
        
        
        
        cell.backgroundColor = color
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = color
        cell.selectedBackgroundView = selectedBackgroundView
        
        
        
        cell.configure(with: UIImage(named: "Series1.png")!, and: list[indexPath.row])
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = EpisodeDetailViewController(model: list[indexPath.row])
        
        navigationController?.pushViewController(detailViewController, animated: false)
    }

    
    
}

