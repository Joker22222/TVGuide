//
//  APIClient.swift
//  TVGuide
//
//  Created by Fernando on 22/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol APIClientInterface {
    func getAPIConfiguration(success:@escaping (_ result: APIConfiguration) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getPopularMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getUpcomingMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getTopRatedMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getDetailMovie(movieId: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getImage(_ url: String, success:@escaping (_ response: UIImage) -> Void, fail:@escaping (_ error: NSError) -> Void)
    func getVideosMovie(movieId: Int!, success:@escaping (_ result: [VideoMovie]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getPopularShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getOnTheAirShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getTopRatedShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void)
    func getVideosShow(showId: Int!, success:@escaping (_ result: [VideoMovie]) -> Void, fail: @escaping (_ error: Error) -> Void)
}

class APIClient : APIClientInterface {
    func getAPIConfiguration(success:@escaping (_ result: APIConfiguration) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.APIConfig).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(APIConfiguration.self, from: json!)
                    success(result)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getPopularMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.popularMovies(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getUpcomingMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.upcomingMovies(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getTopRatedMovies(page: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.topRatedMovies(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getDetailMovie(movieId: Int!, success:@escaping (_ result: [Movie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.movieDetail(movieId: movieId)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }

    func getVideosMovie(movieId: Int!, success:@escaping (_ result: [VideoMovie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.movieVideos(movieId: movieId)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(VideosMovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getImage(_ url: String, success:@escaping (_ response: UIImage) -> Void, fail:@escaping (_ error: NSError) -> Void) {
        Alamofire.request(url)
            .responseImage { response in
                if response.result.isSuccess {
                    success(response.result.value!)
                } else {
                    fail(response.result.error! as NSError)
                }
        }
    }

    func getPopularShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.popularShows(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ShowResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getOnTheAirShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.onTheAirShows(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ShowResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getTopRatedShows(page: Int!, success:@escaping (_ result: [Show]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.topRatedShows(page: page)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ShowResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
    
    func getVideosShow(showId: Int!, success:@escaping (_ result: [VideoMovie]) -> Void, fail: @escaping (_ error: Error) -> Void) {
        Alamofire.request(Router.showVideos(showId: showId)).responseJSON { response in
            if response.result.isSuccess {
                let json = response.data
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(VideosMovieResult.self, from: json!)
                    success(result.results)
                }catch let error {
                    fail(error)
                }
            } else {
                fail(response.result.error!)
            }
        }
    }
}

