//
//  ViewController.swift
//  PracticaPelisIOS
//
//  Created by Jesus on 8/5/24.
//

import UIKit


class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var search: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    var model:Array<Film> = []
    let api=ApiHttp()
    var searchActive=false

    override func viewDidLoad() {
        super.viewDidLoad()

        search.delegate = self
        tableView.dataSource=self

        // Do any additional setup after loading the view.
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
    
        print("Texto de search: \(searchBar.text!)")
    
        Task{
            do {
                try await model = api.searchByName(query: searchBar.text!)
                print ("Prueba recibida: \(model[0].Title)")
            
            } catch {
                print ("No se ha podido conectar")
            }
        tableView.reloadData()
    }
}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "peliCell", for:indexPath) as! TableViewCell
    
        let fila = model[indexPath.row]

        cell.render(imagen:fila.Poster!, titulo:fila.Title)
    
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
               case "goToDetail":
                   let destinationViewControler=segue.destination as! DetailViewController
            
                    let fila=tableView.indexPathForSelectedRow
                    let peli=model[fila!.row]
                    
                   // print ("La fila seleccionada es: \(fila!.row)")
                   destinationViewControler.filmParam=peli
               default:
                   return
               }
    }
    
    
}
