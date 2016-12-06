//
//  BaseTableViewController.swift
//  Dorado
//
//  Created by Etienne Goulet-Lang on 11/28/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import BaseUtils

open class BaseTableViewController: BaseUIViewController, BaseRowUITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    public let tableView = BaseRowUITableView(frame: CGRect.zero)
    private let searchController = UISearchController(searchResultsController: nil)
    
    override open func createLayout() {
        super.createLayout()
        
        self.view.addSubview(tableView)
        tableView.baseRowUITableViewDelegate = self
        tableView.setModels(models: self.createModels())
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        if let scopes = self.getScopes() {
            searchController.searchBar.scopeButtonTitles = scopes
        }
        
        if addSearchBarHeader() {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    override open func frameUpdate() {
        super.frameUpdate()
        
        self.tableView.frame = CGRect(
            x: 0, y: self.effectiveTopLayoutGuide,
            width: self.view.bounds.width,
            height: self.effectiveBottomLayoutGuide - self.effectiveTopLayoutGuide)
    }
    
    open func createModels() -> [BaseRowModel] {
        return []
    }
    
    open func tapped(model: BaseRowModel, view: BaseRowView) {}
    open func longPressed(model: BaseRowModel, view: BaseRowView) {}
    
    // MARK: - Search Bar Delegate -
    public func updateSearchResults(for searchController: UISearchController) {
        let index = searchController.searchBar.selectedScopeButtonIndex
        filterContentForSearchText(scope: searchController.searchBar.scopeButtonTitles?[index], text: searchController.searchBar.text)
    }
    public func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(scope: searchBar.scopeButtonTitles?[selectedScope], text: searchBar.text)
    }
    
    open func filterContentForSearchText(scope: String?, text: String?) {
        self.tableView.filter(scope: scope, text: text)
    }
    
    open func addSearchBarHeader() -> Bool {
        return true
    }
    open func getScopes() -> [String]? {
        return nil
    }
    
}
