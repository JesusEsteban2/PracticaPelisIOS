//
//  ApiRest.swift
//  PracticaPelisIOS
//
//  Created by Jesus on 8/5/24.
//

import Foundation

class searchResponse:Codable {
    var search:[Film]
    var totalResults:Int
    var response:Bool
}

class IdResponse:Codable{
    var title:String
    var year:Int
    var runtime:String
    var genre:String
    var director:String
    var plot:String
    var country:String
    var poster:String
    var imdbID:String
    var response:Bool
    
    func toFilm()->Film {
        var newFilm=Film(title:title,year:year,runtime:runtime,genre:genre,director:director,plot:plot,country:country,poster:poster,imdbID:imdbID)
        return newFilm
    }
}

class Film:Codable {
    var title:String
    var year:Int
    var runtime:String
    var genre:String
    var director:String
    var plot:String
    var country:String
    var poster:String
    var imdbID:String
    
    init(title: String, year: Int, runtime: String, genre: String, director: String, plot: String, country: String, poster: String, imdbID: String) {
        self.title = title
        self.year = year
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.plot = plot
        self.country = country
        self.poster = poster
        self.imdbID = imdbID
    }
}


class ApiHttp {
    //let baseUrl = "https://www.superheroapi.com/api.php/7252591128153666/"
    // Ejemplo http://www.omdbapi.com/?t=guardian&plot=full&apikey=71befb5b
    let baseUrl = "https://www.omdbapi.com/?apikey=71befb5b&"

    var films:[Film]=[]

    
    
    func searchByName(query: String) async throws-> Array<Film>{
        
        var response:[Film]=[]
        //Si no se ha pasado parámetro devolver.
        if query.isEmpty{
            print ("Valor vacio en busqueda")
            return (response)
        }
        
        //Componer URL para pasar a la llamada
        let url = baseUrl + "s=\(query)"
        //Capturar la respuesta de la llamada en response.
        response=try await performAPICall(urlString: url,tipo:1)
        //Devolver la lista de superheroes
        return (response)
    }
    
    func loadById(sid: String) async throws-> Film{
        
        var response:[Film]=[]
        //Si no se ha pasado parámetro devolver.
        if sid.isEmpty{
            print ("Valor vacio en busqueda")
            return (response[0])
        }
        
        //Componer URL para pasar a la llamada
        let url=baseUrl + "i=\(sid)"
        //Capturar la respuesta de la llamada en response.
        response=try await performAPICall(urlString: url,tipo:2)
        //Devolver la lista de superheroes
        return (response[0])
    }
    
    private func performAPICall(urlString:String, tipo:Int) async throws -> [Film] {
        var response1:searchResponse?=nil
        var response2:IdResponse?=nil
        var retorno:[Film]=[]
        //Establecer URL
        let url = URL(string: urlString)!
        // print ("Llamada a api")
        let (data,_) = try await URLSession.shared.data(from: url)
        print ("Datos recibidos: \(data.count)")
        //print ("Procesado con Decoder")
        let decoder=JSONDecoder()
        // No funciona con los guiones medios
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            if tipo==1 {
                response1 = try decoder.decode(type(of: response1), from: data)
                retorno=response1!.search
            } else {
                response2 = try decoder.decode(type(of: response2), from: data)
                retorno.append(response2!.toFilm())
            }
        }
        print ("Decoder Terminado")
        
        return (retorno)
    }
    
    
        
    
}
