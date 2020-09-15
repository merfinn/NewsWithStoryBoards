//
//  Utility.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 15.09.20.
//  Copyright © 2020 Merve Kavaklioglu. All rights reserved.
//

import Foundation

final class Utility {
    
    class func getFormattedDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    class func publisherFormatter(publishedAt: Date?, author: String?) -> String {
        
        if publishedAt != nil && author != nil {
            return (Utility.getFormattedDate(date: publishedAt!)!) + " , " + (author!)
        } else if publishedAt != nil {
            return Utility.getFormattedDate(date: publishedAt!)!
        } else if author != nil {
            return author!
        }
        return ""
    }
}
