//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SearchViewController: UIViewController {
    private let searchView = SearchView()
    private var userNickname = UserDefaults.standard.string(forKey: "userNickname")!
    private var userSearchWords: [String] = UserDefaults.standard.stringArray(forKey: "userSearchWords") ?? [] {
        didSet {
            UserDefaults.standard.set(userSearchWords, forKey: "userSearchWords")
            searchView.tableView.reloadData()
            searchView.settingView(searchWords: userSearchWords)
        }
    }
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
        addEventHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNickname = UserDefaults.standard.string(forKey: "userNickname")!
        settingNavigation(title: "\(userNickname)'s MEANING OUT", rightBarItem: nil)
        removeNavigationBarUnderline()
        searchView.settingView(searchWords: userSearchWords)
    }
}

extension SearchViewController {
    private func settingDelegate() {
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.register(SearchWordTableViewCell.self, forCellReuseIdentifier: SearchWordTableViewCell.identifier)
    }
    
    private func addEventHandler() {
        searchView.removeAllButton.addTarget(self, action: #selector(removeAllButtonClicked), for: .touchUpInside)
    }
    @objc private func removeAllButtonClicked() {
        userSearchWords = []
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        userSearchWords.insert(searchText, at: 0)
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchKeyword = searchBar.text ?? ""
        searchBar.text = nil
        view.endEditing(true)
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTableViewCell.identifier, for: indexPath) as! SearchWordTableViewCell
        cell.selectionStyle = .none
        cell.update(word: userSearchWords[indexPath.row])
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
        cell.wordLabel.tag = indexPath.row
        cell.wordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(wordLabelClicked)))
        return cell
    }
    
    @objc private func removeButtonClicked(sender: UIButton) {
        var searchWords = UserDefaults.standard.stringArray(forKey: "userSearchWords") ?? []
        userSearchWords.remove(at: sender.tag)
    }
    @objc private func wordLabelClicked(sender: UITapGestureRecognizer ) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchKeyword = userSearchWords[sender.view!.tag]
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}
