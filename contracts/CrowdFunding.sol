// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;


contract Crowdfunding {
    // Variables
    address public owner; // Project owner
    uint256 public goal; // Funding goal in wei
    uint256 public deadline; // Deadline as a timestamp
    uint256 public totalFunds; // Total funds raised

    mapping(address => uint256) public contributions; // Tracks contributions by address

    // Events
    event ContributionReceived(address contributor, uint256 amount);
    event GoalReached(uint256 totalFunds);
    event FundsWithdrawn(address owner, uint256 amount);
    event RefundIssued(address contributor, uint256 amount);

    // Modifier to restrict functions to the project owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Modifier to ensure the goal has not been met and the deadline has not passed
    modifier ongoingCampaign() {
        require(block.timestamp <= deadline, "The crowdfunding campaign has ended");
        _;
    }

    // Constructor to initialize the contract
    constructor(uint256 _goal, uint256 _duration) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _duration;
    }

    // Function to contribute to the crowdfunding campaign
    function contribute() external payable ongoingCampaign {
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        // Check if the goal has been reached
        if (totalFunds >= goal) {
            emit GoalReached(totalFunds);
        }
    }

    // Function for the owner to withdraw funds if the goal is met
    function withdrawFunds() external onlyOwner {
        require(block.timestamp > deadline, "Campaign is still ongoing");
        require(totalFunds >= goal, "Funding goal not met");

        uint256 amount = totalFunds;
        totalFunds = 0;

        payable(owner).transfer(amount);
        emit FundsWithdrawn(owner, amount);
    }

    // Function to refund contributors if the goal is not met
    function refund() external {
        require(block.timestamp > deadline, "Campaign is still ongoing");
        require(totalFunds < goal, "Funding goal has been met");

        uint256 contribution = contributions[msg.sender];
        require(contribution > 0, "No contributions to refund");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contribution);

        emit RefundIssued(msg.sender, contribution);
    }

    // Function to get the remaining time until the deadline
    function timeLeft() public view returns (uint256) {
        if (block.timestamp >= deadline) {
            return 0;
        }
        return deadline - block.timestamp;
    }

    // Function to get the remaining amount needed to reach the goal
    function amountNeeded() public view returns (uint256) {
        if (totalFunds >= goal) {
            return 0;
        }
        return goal - totalFunds;
    }
}
