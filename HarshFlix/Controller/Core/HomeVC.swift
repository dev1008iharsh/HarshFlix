//
//  HomeVC.swift
//  Harshflix
 
import UIKit

// enum for per section movies shown on home screen
enum Sections : Int {
    
    case TrendingMovies = 0
    case TrendingTV = 1
   
    
}

class HomeVC: UIViewController {
    
    //MARK: -  Properties
    
    var arrTrendingMovies : [MovieModel] = [MovieModel]()

    private var topHeader : HomeTopHeaderView?
    
    private var randomNumberForHeader = -1
    
    let arrSectionTitles : [String] = ["Trending Movies","Trending TV","Popular","Screening in Theatre","Top Rated"]
    
    private let tblFeedHome : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MovieCollectionTVC.self, forCellReuseIdentifier: MovieCollectionTVC.identifier)
        table.showsVerticalScrollIndicator = false
     
        
        return table
    }()
    
    
    //MARK: -  ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tblFeedHome)
    
        
        configureNavbar()
        
        fetchApiData()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tblFeedHome.frame = view.bounds
    }
    
    //MARK: -  SetUp Table HeaderView
    func setUptableHeader(){
        
        topHeader = HomeTopHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 480))
        tblFeedHome.tableHeaderView = topHeader
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topHeader?.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if randomNumberForHeader != -1{
            let model = self.arrPopular[randomNumberForHeader]
    
        }
        
    }
    
    
    //MARK: -  API Call Functions
    func fetchApiData(){
        
        DispatchQueue.main.async {
            self.getTrendingMoviesApi()
   
            self.getTopRatedApi()
        }
        
    }
    
    private func getTrendingMoviesApi(){
         
        ApiCaller.shared.getTrendingMovies { result in
            switch result {
                
         
            case .failure(let error):
                print(error.localizedDescription)
            }
             
        }
    }
    private func getTrendingTVApi(){
        ApiCaller.shared.getTrendingTVshows { result in
            switch result {
            case .success(let title):
                self.arrTrendingTV = title
         
        }
    }
    private func getPopularApi(){
        ApiCaller.shared.getPopularMovies { result in
            switch result {
            case .success(let title):
       
                    self?.tblFeedHome.reloadData()
                    if let titleS = self?.arrPopular[self?.randomNumberForHeader ?? 0]{
                        self?.topHeader?.configureHeaderView(with: titleS)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func getScreeninginTheatreApi(){
        ApiCaller.shared.getScreeningInTheaterMovies { result in
            switch result {
            case .success(let title):
                self.arrScreeningMovies = title.reversed()
                DispatchQueue.main.async {[weak self] in
                    self?.tblFeedHome.reloadData()
          
        }
    }
    private func getTopRatedApi(){
      
                
                DispatchQueue.main.async {[weak self] in
                    self?.tblFeedHome.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: -  SetUp NavigationBar
    private func configureNavbar() {
      
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(self.tapRightBTn(_:))), UIBarButtonItem (image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: #selector(self.tapRightBTn(_:)))
        ]
        
        navigationController?.navigationBar.tintColor = .systemRed
        
        
    }
    @objc func tapLogo(_ sender: Any? = nil) {
        UtilityManager().showAlert(title: "HarshFlix - Harsh Darji", message: "Built Programatically - This application is made by harsh using native swift language, On top of that this app developed without using storyboard with coredata. Backend managed by themoviedb.org and youtube api", view: self)
    }
    @objc func tapRightBTn(_ sender: Any? = nil) {
        UtilityManager().showAlert(title: "Coming Soon", message: "This part of the application is under Developement", view: self)
    }
    
    
}

//MARK: -  Manage CollectionView Cell Did Tap Method Protocol Delegate
extension HomeVC: DidTapProtocol {
    func cellDidTappedDelegateFunc(titleModel : MovieModel) {

            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



//MARK: -  UITableViewDelegate, UITableViewDataSource
extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCollectionTVC.identifier, for: indexPath) as? MovieCollectionTVC else { return UITableViewCell() }
        cell.delegateCellTap = self
        cell.backgroundColor = .systemBackground
        cell.fetchSavedDataFromCoreData()
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configureMovie(with : arrTrendingMovies)
            
     
            
        case Sections.TopRated.rawValue:
            cell.configureMovie(with : arrTopRated)
            
        default:
            print("default")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        switch indexPath.section {
            
        case Sections.TrendingMovies.rawValue:
            return arrTrendingMovies.count == 0 ? 0 : 180
     
            
        case Sections.Screening.rawValue:
            return arrScreeningMovies.count == 0 ? 0 : 180
            
        case Sections.TopRated.rawValue:
            return arrTopRated.count == 0 ? 0 : 180
            
        default:
            print("default")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case Sections.TrendingMovies.rawValue:
            return arrTrendingMovies.count == 0 ? 0 : 40
            
        case Sections.TrendingTV.rawValue:
            return arrTrendingTV.count == 0 ? 0 : 40
            
        case Sections.Popular.rawValue:
            return arrPopular.count == 0 ? 0 : 40
   
            
        default:
            print("default")
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont (ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 16, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        
        header.textLabel?.text = header.textLabel?.text?.capitalized
         
        
        // manage dark light mode for header view title text color
        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
            if self.traitCollection.userInterfaceStyle == .light {
                header.textLabel?.textColor = .black
            } else {
                header.textLabel?.textColor = .white
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrSectionTitles[section]
    }
    
    //MARK: -  Hide Top navigation bar when table scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
     
}
