//
//  DownlodsVC.swift
//  Harshflix

//
//  Created by My Mac Mini on 19/12/23.
//

import UIKit

class DownlodsVC: UIViewController {

    //MARK: -  Properties
    
    var arrDownload : [TitleItem] = [TitleItem]()
    
    public let tblDownload : UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MoviesTVC.self, forCellReuseIdentifier: MoviesTVC.identifier)
     
    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
      
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
         
        view.addSubview(tblDownload)
         
        tblDownload.dataSource = self
        tblDownload.delegate = self
        
      NSNotification.Name(Constants.keyReloadTablDownload), object: nil, queue: nil) { _ in
            self.fetchSavaDataFromCoreData()
        }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
    }
    
    //MARK: - Fetch CoreData
    //getting downloded data from coredata
    private func fetchSavaDataFromCoreData(){
        
        DataPersistenceManager.shared.fetingTitleFromDataBase { [weak self] result in
            switch result{
            case .success(let titles):
                
                self?.arrDownload = titles
                self?.tblDownload.reloadData()
    
}

//MARK: -  UITableViewDelegate, UITableViewDataSource
extension DownlodsVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDownload.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let avgVote = Double(round(10 * (title.vote_average)) / 10)
        let img = (Constants.IMAGE_URL + (title.poster_path ?? "") )
        
        cell.configure(with: MovieViewModel(movieTitleName: ((title.original_title ?? title.original_name) ?? "Unknown Title" ), movieImgUrl: img, movieAvgVote: "Average Voting : \( "\(avgVote)/10" )"))
        cell.btnDownload.isHidden = true
        return cell
        
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            
            let vc = MovieDetailVC()
            
            // converting coredata model into my model
            guard let titleItemModel = self?.arrDownload[indexPath.row] else{
                return
            }
            
             
            self?.navigationController?.pushViewController(vc, animated: true)
   
    //MARK: -  Left swipe to delete saved data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
       
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: arrDownload[indexPath.row]) { result in
                switch result{
                case .success():
                    print("deleteed from database")
                    
                    
                    UtilityManager().postAllNotificationForReloadDownloadData()
                    
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
         
    
}
