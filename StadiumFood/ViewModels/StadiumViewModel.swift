//
//  StadiumViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/27/24.
//

import SwiftUI
import FirebaseFirestore
import Combine

class StadiumViewModel: ObservableObject {
    @Published var stadiums: [StadiumModel] = []
    
    init() {
        fetchStadiums()
    }
    
    // 구장데이터 가져오기
    func fetchStadiums() {
        Firestore.firestore().collection("stadiums").order(by: "order").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching stadiums: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                self.stadiums = snapshot.documents.compactMap { document -> StadiumModel? in
                    let id = document.documentID
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let teams = data["teams"] as? [String] ?? []
                    let destinationView = data["destinationView"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    return StadiumModel(id: id, name: name, imageURL: imageURL, teams: teams, destinationView: destinationView, order: 0, restaurants: [])
                }
            }
        }
    }
    
    // 구장 뷰 이동 로직
    func destinationViewForStadium(_ stadium: StadiumModel) -> some View {
        switch stadium.destinationView {
        case "JamsilView":
            return AnyView(JamsilView())
        case "GochuckView":
            return AnyView(GochuckView())
        case "WizParkView":
            return AnyView(WizParkView())
        case "LandersFieldView":
            return AnyView(LandersFieldView())
        case "EaglesParkView":
            return AnyView(EaglesParkView())
        case "LionsParkView":
            return AnyView(LionsParkView())
        case "ChampionsParkView":
            return AnyView(ChampionsParkView())
        case "NCParkView":
            return AnyView(NCParkView())
        case "SajicView":
            return AnyView(SajicView())
        default:
            return AnyView(Text("기본적으로 표시할 뷰입니다."))
        }
    }
}
