// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to hold voter details
    struct Voter {
        bool voted;
        uint8 vote;
        bool isRegistered;
    }

    // Structure to hold proposal details
    struct Proposal {
        uint8 id;
        string name;
        uint voteCount;
    }

    // State variables
    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    // Constructor to initialize proposals
    constructor(string[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].isRegistered = true;

        for (uint8 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                id: i,
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Function to register a voter
    function registerVoter(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can register voters.");
        require(!voters[voter].isRegistered, "Voter is already registered.");

        voters[voter].isRegistered = true;
    }

    // Function to vote for a proposal
    function vote(uint8 proposalId) public {
        require(voters[msg.sender].isRegistered, "You must be registered to vote.");
        require(!voters[msg.sender].voted, "You have already voted.");

        voters[msg.sender].voted = true;
        voters[msg.sender].vote = proposalId;

        proposals[proposalId].voteCount += 1;
    }

    // Function to get the winning proposal
    function winningProposal() public view returns (uint8 winningProposalId) {
        uint maxVoteCount = 0;
        for (uint8 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > maxVoteCount) {
                maxVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
    }

    // Function to get the name of the winning proposal
    function winnerName() public view returns (string memory) {
        return proposals[winningProposal()].name;
    }
}
