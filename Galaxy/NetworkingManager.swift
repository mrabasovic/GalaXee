//
//  NetworkingManager.swift
//  Galaxy
//
//  Created by mladen on 7.8.21..
//

import Foundation

protocol apiDelegate {
    func sendData(date: String, image: String, explanation: String)
}

struct NetworkingManager{
    var sendDataDelegate : apiDelegate!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key=zkEROvyf0fdSmt2BfgkqriTUsHlbMREbo6nDUleh"
    
    // ako hoces na odredjen datum npr https://api.nasa.gov/planetary/apod?api_key=zkEROvyf0fdSmt2BfgkqriTUsHlbMREbo6nDUleh&date=2021-07-07
    
    func fetchData(year: String, month: String, day: String){
        
        if year == "" && month == "" && day == ""{
            let currentDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentDate)
            let month = calendar.component(.month, from: currentDate)
            let day = calendar.component(.day, from: currentDate)
            
            let finalDate = "\(year)-\(month)-\(day)"
            let urlString = apiURL+"&date=\(finalDate)" // dodaj ovde jos neke parametre ako hoces
            performRequest(urlString: urlString)
        }else{
            let finalDate = "\(year)-\(month)-\(day)"
            let urlString = apiURL+"&date=\(finalDate)" // dodaj ovde jos neke parametre ako hoces
            performRequest(urlString: urlString)
        }
        
    }
    
    func performRequest(urlString: String){
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        
        task.resume()
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            print(error)
            return
        }
        if let safeData = data {
            parseJSON(data: safeData)
        }
    }
    
    
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do{
            print("Usao ovde")
            let decodedData = try decoder.decode(NasaData.self, from: data)
            print(decodedData.hdurl)
            sendDataDelegate.sendData(date: decodedData.date, image: decodedData.hdurl, explanation: decodedData.explanation)
        }catch{
            print("ERROR")
        }
    }
    
    
    
}
