//
//  MoviesTVC.swift
//  Harshflix
//
//  Created by My Mac Mini on 20/12/23.
//

import UIKit

//MARK: -  Used on UpcomingVC, SearchVC, DownlodVC

class MoviesTVC: UITableViewCell {
    
    //MARK: -  Properties
    static let identifier = "MoviesTVC"
    

        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let lblAvgVote: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let imgMovie: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
 
        return imgView
    }()
    
    public let btnDownload: UIButton = {
        
        let button = UIButton()
        let image = UIImage(systemName: "arrow.down.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
     
    //MARK: -  LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgMovie)
        contentView.addSubview(lblTitle)
   
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgMovie.frame = contentView.bounds
    }
    
    
    
    
    //MARK: -  SetUp Screen
    private func appplyConstrain(){
        
        let imgMovieConstrains = [
            imgMovie.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: bottomAnchor, constant: -10),
            imgMovie.widthAnchor.constraint(equalToConstant: 80),
             
        ]
        
        let btnPlayConstrains = [
            btnDownload.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
 
        ]
        
        let lblTitleConstrains = [
            lblTitle.leadingAnchor.constraint(equalTo: imgMovie.trailingAnchor,constant: 15),
      
        ]
        
        let lblAvgVoteConstrains = [
  
            lblAvgVote.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 5)
            
        ]
        
        
    
        NSLayoutConstraint.activate(lblAvgVoteConstrains)
        NSLayoutConstraint.activate(btnPlayConstrains)
    }
    
    public func configure(with model : MovieViewModel){
        guard let myUrl = URL(string: model.movieImgUrl) else {
            return
        }
        imgMovie.sd_setImage(with: myUrl)
   
    }
    
    //MARK: - Fetch CoreData
    //getting downloded data from coredata
    public func fetchSavedDataFromCoreData(){
        self.arrIdOfDownlodedMovies.removeAll()
        DataPersistenceManager.shared.fetingTitleFromDataBase { [weak self] result in
            switch result{
            case .success(let titles):
                
        
                    let int64Value: Int64 = downlod.id
          
                }
             
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
 
    public func showHideDownlodButton(cellMoviewID : Int){
        if arrIdOfDownlodedMovies.contains(cellMoviewID){
            self.btnDownload.isHidden = true
  
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
 
