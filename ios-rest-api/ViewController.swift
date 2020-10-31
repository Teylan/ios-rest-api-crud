//
//  ViewController.swift
//  ios-rest-api
//
//  Created by Brian Bansenauer on 9/25/19.
//  Copyright © 2019 Cascadia College. All rights reserved.
//

import UIKit

    let DomainURL = "https://www.orangevalleycaa.org/api/"
    
class User: Codable {
    var guid : String?
    var music_url : String?
    var name : String?
    var description : String?

    enum CodingKeys : String, CodingKey{
        case guid = "id"
        case music_url, name, description
    }
    
    // Read an User record from the server
    static func fetch(withID id:Int){
            let URLstring = DomainURL + "music/\(id)"
            if let url = URL.init(string: URLstring){
                let task = URLSession.shared.dataTask(with: url, completionHandler:
                {(dataFromAPI, response, error) in
                    print(String.init(data:dataFromAPI!, encoding: .ascii) ?? "no data")
                    if let myUser = try? JSONDecoder().decode(User.self, from:  dataFromAPI!){
                        print(myUser.name ?? "No name")
                    }
                })
                task.resume()
            }
    }
    // Create a new User record using a REST API "POST"
    func postToServer(){
        let URLstring = DomainURL + "music/"
        var postRequest = URLRequest.init(url: URL.init(string: URLstring)!)
        postRequest.httpMethod = "POST"
        postRequest.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: postRequest){ (data, response, error) in print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
        }
        
        //TODO: Encode the user object itself as JSON and assign to the body
        
        //TODO: Create the URLSession task to invoke the request
        
        task.resume()
    }
    
    // Update this User record using a REST API "PUT"
    func updateServer(withID id:Int){
        
        let URLstring = DomainURL + "music/id/\(self.guid!)"
        var postRequest = URLRequest.init(url: URL.init(string: URLstring)!)
        postRequest.httpMethod = "PUT"
        postRequest.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: postRequest){ (data, response, error) in print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
        }
        
        task.resume()
        
    }
    
    // Delete this User record using a REST API "DELETE"
    func deleteFromServer(withID id:Int){
        guard self.guid != nil else { return }
        let URLstring = DomainURL + "music/id/\(self.guid!)"
        var postRequest = URLRequest.init(url: URL.init(string: URLstring)!)
        postRequest.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: postRequest){ (data, response, error) in print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
        }
        
        task.resume()
    }
}



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //User.fetch(withID: 2)
        
        //TODO: Assign values to this User object properties
        let myUser = User()
        myUser.guid = "1"
        myUser.music_url = "12123123"
        myUser.name = "name"
        
        //Test POST method
        myUser.postToServer()
        
        //Test PUT method
        myUser.description = "123456789"
        myUser.updateServer(withID: 1)
        
        //Test DELETE method
        myUser.deleteFromServer(withID: 1)
        
    }


}

