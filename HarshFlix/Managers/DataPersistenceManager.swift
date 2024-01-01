//
//  DataPersistenceManager.swift
//  Harshflix
 
 
import UIKit
import CoreData

enum DatabaseError : Error {
    
    case faildToSaveData
    case faildToFetchData
    case faildToDeleteData
    
}

class DataPersistenceManager{
    static let shared = DataPersistenceManager()
    
    //MARK: -  Save Movie in Downlod Menu using coredata
    
    func downlodTitleWith (model : MovieModel, completion : @escaping(Result<Void,Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let contex = appDelegate.persistentContainer.viewContext
 
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.poster_path = model.poster_path
        item.overview = model.overview
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        
        do{
            try contex.save()
            completion(.success(()))
 
    }
    
    //MARK: -  Fetch movies from coredata
    func fetingTitleFromDataBase(completion : @escaping(Result<[TitleItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        
        do{
            let titles = try context.fetch(request)

    }
    
    
    //MARK: -  delete from coredata for downlod menu
    func deleteTitleWith(model : TitleItem, completion :@escaping(Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let contex = appDelegate.persistentContainer.viewContext
        contex.delete(model)
        
        do{
            try contex.save()
            completion(.success(()))
        }catch{
            print(error.localizedDescription)
            completion(.failure(DatabaseError.faildToDeleteData))
        }
    }
    
    //MARK: -  delete from coredata for downlod menu
    func deleteTitleUsingIDWith(id : Int, completion :@escaping(Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let contex = appDelegate.persistentContainer.viewContext
     
        let request : NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        if let result = try? contex.fetch(request) {

 
        do{
            try contex.save()
            completion(.success(()))
        }catch{
            print(error.localizedDescription)
            completion(.failure(DatabaseError.faildToDeleteData))
        }
    }
}
