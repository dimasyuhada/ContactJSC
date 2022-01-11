//
//  ViewController.swift
//  ContactJSC
//
//  Created by Dimas Syuhada on 11/01/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    
    var contact: [Contact]?
    var listContact = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(ContactTableViewCell.nib(), forCellReuseIdentifier: ContactTableViewCell.identifier)
        
        getJSON{
            print("Success!")
            self.tableView.reloadData()
        };
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: API Request
    func getJSON(completed: @escaping() -> ()){
        let url = URL (string: "https://randomuser.me/api?results=20&exc=login&nat=us&noinfo")
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error == nil {
                do{
                    self.contact = try JSONDecoder().decode([Contact].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        cell.configure(with: listContact[indexPath.row])
        return cell
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

