//
//  Extensions.swift
//  Harshflix
 
import UIKit

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    
    
}
 
 
