//
//  TrainTicketMachineTests.swift
//  TrainTicketMachineTests
//
//  Created by João Gameiro on 27/03/18.
//  Copyright © 2018 JG.com. All rights reserved.
//

@testable import TrainTicketMachine
import Quick
import Nimble

class SearchStationsViewControllerTests: QuickSpec {
    
    // MARK: Cases
    override func spec() {
        var sut : SearchStationsViewController!
        describe("SearchStationsViewController") {
            beforeEach {
                sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchStationsViewController") as! SearchStationsViewController
                
                _ = sut.view // loads viewcontroller to memory
            }
            context("after view is loaded") {
                it("tableview should have has many rows as the number of stations in the fetched list") {
                    expect(sut.tableView.numberOfRows(inSection: 0)).to(equal(sut.displayedStationList.count))
                }
            }
            context("TableView") {
                var sectionTitle: String!
                beforeEach {
                    sectionTitle = (sut.tableView(sut.tableView, titleForHeaderInSection: 0))!
                }
                it("section title should read Full Station List") {
                    expect(sectionTitle).to(equal(SearchStationsViewControllerStrings.fullStationTitle))
                }
                
                var cell: UITableViewCell!
                beforeEach {
                    cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                }
                
                it("first cell should show the name of the first station in the list") {
                    let stationName = sut.displayedStationList[0].name
                    expect(cell.textLabel?.text).to(equal(stationName))
                }
                context("SearchBar Not Active") {
                    var searchBar: UISearchBar!
                    
                    beforeEach {
                        searchBar = sut.navigationItem.searchController?.searchBar
                    }
                    it("should read Insert Station Name") {
                        expect(searchBar.placeholder).to(equal(SearchStationsViewControllerStrings.searchBarPlaceholder))
                    }
                    context("SearchBar Active"){
                        var searchControllerResults: UISearchResultsUpdating!
                        beforeEach {
                            searchBar = sut.navigationItem.searchController?.searchBar
                            searchControllerResults = sut.navigationItem.searchController?.searchResultsUpdater
                            searchControllerResults.updateSearchResults(for: sut.navigationItem.searchController!)
                        }
                    }
                    it("if there is no text it should be empty") {
                        expect(sut.searchBarIsEmpty()).to(equal(true))
                    }
                    it("should update results when not empty") {
                        expect(sut.navigationItem.searchController?.searchBar.text).to(equal(""))
                    }
                }
            }
            
            // MARK - Interactor Tests
            var interactor: SearchStationsInteractor!
            
            beforeEach {
                interactor = SearchStationsInteractor()
            }
            describe("Station List") {
                var request:  SearchStations.FetchStationsList.Request!
                
                beforeEach {
                    request = SearchStations.FetchStationsList.Request()
                    
                    interactor.fetchStationsList(request: request)
                }
                it("should have 8 entries") {
                    expect(interactor.stations?.count).to(equal(8))
                }
            }
            describe("Filtered Station List for Input Text L") {
                var requestFilteredStations: SearchStations.FilterStationsList.Request!
                
                beforeEach {
                    requestFilteredStations = SearchStations.FilterStationsList.Request(stationsList: sut.displayedStationList, textInput:"L")
                    
                    interactor.filterStationsList(request: requestFilteredStations)
                }
                it("should have 2 matching stations") {
                    expect(interactor.filteredStations.count).to(equal(2))
                }
            }
            describe("Matching Letters List") {
                var requestMatchingLettersList: SearchStations.MatchingLettersForFilteredResults.Request!

                beforeEach {
                    sut.filterStationListForTextInput(list: sut.displayedStationList, input: "L")
                    requestMatchingLettersList = SearchStations.MatchingLettersForFilteredResults.Request(filteredResults: sut.displayedFilteredStationList, textToTrim:"L")
                    interactor.matchingLettersList(request: requestMatchingLettersList)
                    sut.matchingLettersForFilteredList(list: sut.displayedFilteredStationList, textToTrim: "L")
                }
                it("should have 2 matching letters") {
                    expect(interactor.matchingLettersForResults.count).to(equal(2))
                }
                it("should display in separate tableview section") {
                    if(!(sut.displayedMatchingLettersForResultsList.isEmpty)) {
                        expect(sut.tableView.numberOfSections).to(equal(2))
                    }
                }
            }
        }
    }
}
