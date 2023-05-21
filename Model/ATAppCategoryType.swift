//
//  ATAppCategoryType.swift
//  Atlas
//
//  Created by Yuto on 2023/05/12.
//

import Foundation
import SwiftUI

enum ATAppCategoryType: String {
    
    case browser = "browser"
    case business = "public.app-category.business"
    case developerTools = "public.app-category.developer-tools"
    case education = "public.app-category.education"
    case entertainment = "public.app-category.entertainment"
    case finance = "public.app-category.finance"
    case games = "public.app-category.games"
    case actionGames = "public.app-category.action-games"
    case adventureGames = "public.app-category.adventure-games"
    case arcadeGames = "public.app-category.arcade-games"
    case boardGames = "public.app-category.board-games"
    case cardGames = "public.app-category.card-games"
    case casinoGames = "public.app-category.casino-games"
    case diceGames = "public.app-category.dice-games"
    case educationalGames = "public.app-category.educational-games"
    case familyGames = "public.app-category.family-games"
    case kidsGames = "public.app-category.kids-games"
    case musicGames = "public.app-category.music-games"
    case puzzleGames = "public.app-category.puzzle-games"
    case racingGames = "public.app-category.racing-games"
    case rolePlayingGames = "public.app-category.role-playing-games"
    case simulationGames = "public.app-category.simulation-games"
    case sportsGames = "public.app-category.sports-games"
    case strategyGames = "public.app-category.strategy-games"
    case triviaGames = "public.app-category.trivia-games"
    case wordGames = "public.app-category.word-games"
    case graphicsDesign = "public.app-category.graphics-design"
    case healthcareFitness = "public.app-category.healthcare-fitness"
    case lifestyle = "public.app-category.lifestyle"
    case medical = "public.app-category.medical"
    case music = "public.app-category.music"
    case news = "public.app-category.news"
    case photography = "public.app-category.photography"
    case productivity = "public.app-category.productivity"
    case reference = "public.app-category.reference"
    case socialNetworking = "public.app-category.social-networking"
    case sports = "public.app-category.sports"
    case travel = "public.app-category.travel"
    case utilities = "public.app-category.utilities"
    case video = "public.app-category.video"
    case weather = "public.app-category.weather"
    
    var allTypes: [Self] {
        return [
            .business, .developerTools, .education, .entertainment, .finance, .games, .actionGames,  .adventureGames, .arcadeGames, .boardGames, .cardGames, .casinoGames, .diceGames, .educationalGames, .familyGames, .kidsGames, .musicGames,  .puzzleGames, .racingGames, .rolePlayingGames, .simulationGames, .sportsGames, .strategyGames, .triviaGames, .wordGames, .graphicsDesign,  .healthcareFitness, .lifestyle, .medical, .music, .news, .photography,  .productivity, .reference, .socialNetworking, .sports, .travel, .utilities, .video, .weather,
        ]
    }
    
}

extension ATAppCategoryType {
    var name: String {
        switch self {
        case .business:
            return "business"
        case .developerTools:
            return "developer tools"
        case .education:
            return "education"
        case .entertainment:
            return "entertainment"
        case .finance:
            return "building.columns.fill"
        case .games, .actionGames, .adventureGames, .arcadeGames, .boardGames, .cardGames, .casinoGames, .diceGames, .educationalGames, .familyGames, .kidsGames, .musicGames, .puzzleGames, .racingGames, .rolePlayingGames, .simulationGames, .sportsGames, .strategyGames, .triviaGames, .wordGames:
            return "games"
        case .graphicsDesign:
            return "graphics design"
        case .healthcareFitness:
            return "healthcare fitness"
        case .lifestyle:
            return "lifestyle"
        case .medical:
            return "medical"
        case .music:
            return "music"
        case .news:
            return "news"
        case .photography:
            return "photography"
        case .productivity:
            return "productivity"
        case .reference:
            return "reference"
        case .socialNetworking:
            return "social Networking"
        case .sports:
            return "sports"
        case .travel:
            return "travel"
        case .utilities:
            return "utilities"
        case .video:
            return "video"
        case .weather:
            return "weather"
        case .browser:
            return "browser"
        }
    }

}

extension ATAppCategoryType {
    
    var symbol: String {
        switch self {
        case .business:
            return "case.fill"
        case .developerTools:
            return "hammer.fill"
        case .education:
            return "graduationcap.fill"
        case .entertainment:
            return "popcorn.fill"
        case .finance:
            return "building.columns.fill"
        case .games, .actionGames, .adventureGames, .arcadeGames, .boardGames, .cardGames, .casinoGames, .diceGames, .educationalGames, .familyGames, .kidsGames, .musicGames, .puzzleGames, .racingGames, .rolePlayingGames, .simulationGames, .sportsGames, .strategyGames, .triviaGames, .wordGames:
            return "gamecontroller.fill"
        case .graphicsDesign:
            return "photo.fill.on.rectangle.fill"
        case .healthcareFitness:
            return "heart.fill"
        case .lifestyle:
            return "chair.fill"
        case .medical:
            return "heart.text.square.fill"
        case .music:
            return "music.note.list"
        case .news:
            return "newspaper.fill"
        case .photography:
            return "camera.fill"
        case .productivity:
            return "paperplane.fill"
        case .reference:
            return "books.vertical.fill"
        case .socialNetworking:
            return "bubble.left.and.bubble.right.fill"
        case .sports:
            return "soccerball"
        case .travel:
            return "beach.umbrella.fill"
        case .utilities:
            return "paperclip"
        case .video:
            return "play.rectangle.fill"
        case .weather:
            return "cloud.sun.fill"
        case .browser:
            return "safari.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .business:
            return .gray
        case .developerTools:
            return .indigo
        case .education:
            return .brown
        case .entertainment:
            return .red
        case .finance:
            return .yellow
        case .games, .actionGames, .adventureGames, .arcadeGames, .boardGames, .cardGames, .casinoGames, .diceGames, .educationalGames, .familyGames, .kidsGames, .musicGames, .puzzleGames, .racingGames, .rolePlayingGames, .simulationGames, .sportsGames, .strategyGames, .triviaGames, .wordGames:
            return .purple
        case .graphicsDesign:
            return .orange
        case .healthcareFitness:
            return .pink
        case .lifestyle:
            return .brown
        case .medical:
            return .pink
        case .music:
            return .red
        case .news:
            return .red
        case .photography:
            return .gray
        case .productivity:
            return .orange
        case .reference:
            return .gray
        case .socialNetworking:
            return .blue
        case .sports:
            return .primary
        case .travel:
            return .green
        case .utilities:
            return .gray
        case .video:
            return .red
        case .weather:
            return .blue
        case .browser:
            return .blue
        }
    }
    
}
