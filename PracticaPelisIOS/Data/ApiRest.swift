//
//  ApiRest.swift
//  PracticaPelisIOS
//
//  Created by Jesus on 8/5/24.
//

import Foundation

struct SearchResponse:Codable {
    let Search:[Film]
    let totalResults:String
    let Response:String
}

struct IdResponse:Codable{
    let Title:String
    let Year:String
    let Runtime:String?
    let Genre:String?
    let Director:String?
    let Plot:String?
    let Country:String?
    let Poster:String?
    let imdbID:String?
    let Response:String
}

struct Film:Codable {
    let Title:String
    let Year:String
    let Runtime:String?
    let Genre:String?
    let Director:String?
    let Plot:String?
    let Country:String?
    let Poster:String?
    let imdbID:String?
    
    init(title: String, year: String, runtime: String, genre: String, director: String, plot: String, country: String, poster: String, imdbID: String) {
        self.Title = title
        self.Year = year
        self.Runtime = runtime
        self.Genre = genre
        self.Director = director
        self.Plot = plot
        self.Country = country
        self.Poster = poster
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
        var response1:SearchResponse?=nil
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
                response1 = try decoder.decode(SearchResponse.self, from: data)
                print ("Parseado: \(response1?.Search)")
                retorno=response1!.Search
            } else {
                response2 = try decoder.decode(IdResponse.self, from: data)
                let film:Film=toFilm(res:response2!)
                retorno.append(film)
            }
        } catch {
            print(error)
        }
        print ("Decoder Terminado")
        
        return (retorno)
    }
    
    func toFilm(res:IdResponse)->Film {
        var newFilm=Film(title:res.Title,
                         year:res.Year,
                         runtime:res.Runtime!,
                         genre:res.Genre!,
                         director:res.Director!,
                         plot:res.Plot!,
                         country:res.Country!,
                         poster:res.Poster!,
                         imdbID:res.imdbID!)
        return newFilm
    }
    
        
    
}
