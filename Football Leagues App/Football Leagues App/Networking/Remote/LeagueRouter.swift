//
//  LeagueRouter.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import Alamofire

enum LeagueRouter: URLRequestConvertible {
    
    case getLeagues()
    case getLeagueInformation(leagueInformationUrl: String)
    case getLeagueTeams(leagueTeamsUrl: String)
    case getTeamInformation(teamInformationUrl: String)
    case getTeamFixtures(teanFixturesUrl: String)
    
    func asURLRequest() throws -> URLRequest {
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .getLeagues:
                relativePath = "http://api.football-data.org/v1/competitions"
            case .getLeagueInformation(let leagueInformationUrl):
                relativePath = "\(leagueInformationUrl)"
            case .getLeagueTeams(let leagueTeamsUrl):
                relativePath = "\(leagueTeamsUrl)"
            case .getTeamInformation(let teamInformationUrl):
                relativePath = "\(teamInformationUrl)"
            case .getTeamFixtures(let teanFixturesUrl):
                relativePath = "\(teanFixturesUrl)"
            }
            var url = URL(string: relativePath!)!
            return url
        }()
        
        var method: HTTPMethod {
            switch self {
            case .getLeagues, .getLeagueInformation, .getLeagueTeams, .getTeamFixtures, .getTeamInformation:
                return .get
            }
        }
        let params: ([String: Any]?) = {
            switch self {
            case .getLeagues, .getLeagueInformation, .getLeagueTeams, .getTeamFixtures, .getTeamInformation:
                return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
        
    }
}
