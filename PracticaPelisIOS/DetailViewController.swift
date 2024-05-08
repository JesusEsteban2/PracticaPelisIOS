//
//  DetailViewController.swift
//  PracticaPelisIOS
//
//  Created by Mañanas on 8/5/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var ano: UILabel!
    @IBOutlet weak var sinopsis: UILabel!
    @IBOutlet weak var duracion: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var genero: UILabel!
    @IBOutlet weak var pais: UILabel!
    
    let api=ApiHttp()
    
    var filmParam:Film?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagen.loadImage(fromURL:(filmParam!.Poster!))
                titulo.text=filmParam?.Title
                ano.text=filmParam?.Year
        Task {
            try await filmParam=api.loadById(sid:filmParam!.imdbID!)
            print ("Prueba recibida: \(filmParam)")
                    sinopsis.text=filmParam?.Plot
                    duracion.text=filmParam?.Runtime
                    director.text=filmParam?.Director
                    genero.text=filmParam?.Genre
                    pais.text=filmParam?.Country
        }
        


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
