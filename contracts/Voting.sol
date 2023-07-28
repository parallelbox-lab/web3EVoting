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

    struct Candidate {
      string name;
      uint numVotes;
    }
    
    struct Voter {
      string name;
      bool authorized;
      uint whom;
      bool voted;
    }

     address public owner;
     string public electionName;

     mapping(address => Voter) public voters;

     // list of all candidates
     Candidate[] public candidates;

     uint public totalVotes;

     function startElection(string memory _electioName) public {
      owner = msg.sender;
      electionName = _electioName;
     }

     function addCandidate(string memory _candidateName) onlyOwner public {
       candidates.push(Candidate(_candidateName, 0));
     }

     function authorizeVoters(address _voterAddress) onlyOwner public {
       voter[_voterAddress].authorized = true;
     }

     function getNumOfCandidates() public view returns (uint) {
      return candidates.length;
     } 

     function vote(uint _candidateIndex) public {
      require(!voters[msg.sender].voted);
      require(voters[msg.sender].authorized);
      voters[msg.sender].voted = true;
      voters[msg.sender].whom = _candidateIndex;

      candidates[_candidateIndex].numVotes++;
     } 

     function getTotalVotes() public view returns(uint) {
      return totalVotes;
     }


    // struct Voters {
    //     bytes32 uid;
    //     uint candidateIDVote;
    // }

    // struct Candidate {
    //     bytes32 name;
    //     bytes32 party;
    //     bool doesExits;
    // }

    // uint numberofCandidates;
    // uint numberofVotes;
    
    // mapping(uint => Candidate) candidates;
    // mapping(uint => Voters) voters;

    // function addCandidates(bytes32 name, bytes32 party) onlyOwner public {
    //  uint candidateID = numberofCandidates++;
    //  candidates[candidateID] = Candidate(name, party, true);
    //  emit addedVoters(candidateID);
    // }

    // function vote(bytes32 uid, uint candidateID) public {
    //     if(candidates[candidateID].doesExits == true){
    //       uint votersID = numberofVotes++;
    //       voters[votersID] = Voters(uid, candidateID);
    //     }
    // }

    // function totatVotes(uint candidateID) public view returns(uint){
    //   uint numOfVotes = 0;
    //   for(uint i =0; i < numberofVotes; i++){
    //     if(voters[i].candidateIDVote == candidateID){
    //       numOfVotes++;
    //     }
    //   }
    //   return numOfVotes;
    // }

    // function getNumOfCandidates() public view returns(uint) {
    //     return numberofCandidates;
    // }

    // function getNumOfVoters() public view returns(uint) {
    //     return numberofVotes;
    // }
    // // returns candidate information, including its ID, name, and party
    // function getCandidate(uint candidateID) public view returns (uint,bytes32, bytes32) {
    //     return (candidateID,candidates[candidateID].name,candidates[candidateID].party);
    // }



    

}
