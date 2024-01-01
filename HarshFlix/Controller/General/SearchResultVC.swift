//
//  SearchVC.swift
//  Harshflix
//
//  Created by My Mac Mini on 20/12/23.
//

import UIKit

protocol ProtocolSearchResult: AnyObject {
    func didTapSearchFunc(_ viewModel: MovieModel)
}

class SearchResultVC: UIViewController {
    
    //MARK: -  Properties
    
    public var arrSearch : [MovieModel] = [MovieModel]()
    
 
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3 - 15), height: 180)
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        
        let collv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collv.register(MovieCVC.self, forCellWithReuseIdentifier: MovieCVC.identifier)
        collv.showsVerticalScrollIndicator = false
        collv.showsHorizontalScrollIndicator = false
        return collv
        
    }()
    
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor  = .systemCyan
        view.addSubview(collvSearch)
        
        collvSearch.dataSource = self
        collvSearch.delegate = self
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collvSearch.frame = view.bounds
    }
    
    
}

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVC.identifier, for: indexPath) as? MovieCVC else { return
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.delegateSearchTapCell?.didTapSearchFunc(self.arrSearch[indexPath.row])
 
