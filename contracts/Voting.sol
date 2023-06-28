// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Voting {
    event addedVoters(uint candidateID);
    address owner;

    constructor() {
     owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;  
    }
    struct Voters {
        bytes32 uid;
        uint candidateIDVote;
    }

    struct Candidate {
        bytes32 name;
        bytes32 party;
        bool doesExits;
    }

    uint numberofCandidates;
    uint numberofVotes;
    
    mapping(uint => Candidate) candidates;
    mapping(uint => Voters) voters;

    function addCandidates(bytes32 name, bytes32 party) onlyOwner public {
     uint candidateID = numberofCandidates++;
     candidates[candidateID] = Candidate(name, party, true);
     emit addedVoters(candidateID);
    }

    function vote(bytes32 uid, uint candidateID) public {
        if(candidates[candidateID].doesExits == true){
          uint votersID = numberofVotes++;
          voters[votersID] = Voters(uid, candidateID);
        }
    }

    function totatVotes(uint candidateID) public view returns(uint){
      uint numOfVotes = 0;
      for(uint i =0; i < numberofVotes; i++){
        if(voters[i].candidateIDVote == candidateID){
          numOfVotes++;
        }
      }
      return numOfVotes;
    }

    function getNumOfCandidates() public view returns(uint) {
        return numberofCandidates;
    }

    function getNumOfVoters() public view returns(uint) {
        return numberofVotes;
    }
    // returns candidate information, including its ID, name, and party
    function getCandidate(uint candidateID) public view returns (uint,bytes32, bytes32) {
        return (candidateID,candidates[candidateID].name,candidates[candidateID].party);
    }



    

}
