// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedMemeVote {
    struct Option {
        string name;
        uint voteCount;
    }

    struct Topic {
        string title;
        Option[] options;
    }

    struct Voter {
        bool hasVoted;
        uint voteCount;
        mapping(uint => mapping(uint => uint)) choices;
    }

    address public admin;
    Topic[] public topics;
    mapping(address => Voter) public voters;
    address[] public voterList;
    uint public totalPool;
    uint public votingStartTime;
    uint public votingEndTime;
    uint public maxVotesPerVoter;
    uint public winningTopicId;
    uint public winningOptionId;
    bool public rewardsDistributed;
    bool public isRewardEnabled;
    uint public rewardPercentage;
    uint public constant VOTING_DURATION = 30 minutes;
    uint public constant COOLDOWN = 5 minutes;

    event VoteCast(address indexed voter, uint topicId, uint optionId, uint amount);
    event RewardsDistributed(uint winningTopicId, uint winningOptionId, uint rewardPerVoter);
    event NewRoundStarted(uint newStartTime);
    event TopicAdded(uint topicId, string title);
    event OptionAdded(uint topicId, uint optionId, string name);
    event TopicDeleted(uint topicId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin only");
        _;
    }

    modifier votingOpen() {
        require(block.timestamp >= votingStartTime && block.timestamp < votingEndTime, "Voting is not open");
        _;
    }

    constructor(
        uint _maxVotesPerVoter,
        bool _isRewardEnabled,
        uint _rewardPercentage
    ) {
        require(_rewardPercentage <= 100, "Reward percentage must be <= 100");
        admin = msg.sender;
        maxVotesPerVoter = _maxVotesPerVoter;
        isRewardEnabled = _isRewardEnabled;
        rewardPercentage = _rewardPercentage;
        votingStartTime = block.timestamp;
        votingEndTime = block.timestamp + VOTING_DURATION;
    }

    function addTopic(string memory title) external onlyAdmin {
        require(!rewardsDistributed, "Cannot add topics after voting ends");
        topics.push();
        uint topicId = topics.length - 1;
        topics[topicId].title = title;
        emit TopicAdded(topicId, title);
    }

    function addOption(uint topicId, string memory optionName) external onlyAdmin {
        require(topicId < topics.length, "Invalid topic ID");
        require(!rewardsDistributed, "Cannot add options after voting ends");
        topics[topicId].options.push(Option({
            name: optionName,
            voteCount: 0
        }));
        emit OptionAdded(topicId, topics[topicId].options.length - 1, optionName);
    }

    function deleteTopic(uint topicId) external onlyAdmin {
        require(topicId < topics.length, "Invalid topic ID");
        require(!rewardsDistributed, "Cannot delete topics after voting ends");
        for (uint i = topicId; i < topics.length - 1; i++) {
            topics[i] = topics[i + 1];
        }
        topics.pop();
        emit TopicDeleted(topicId);
    }

    function vote(uint topicId, uint optionId) external payable votingOpen {
        require(topicId < topics.length, "Invalid topic ID");
        require(optionId < topics[topicId].options.length, "Invalid option ID");
        Voter storage voter = voters[msg.sender];
        require(voter.voteCount < maxVotesPerVoter, "Vote limit reached");
        require(msg.value == 1 ether, "Must pay 1 ETN");

        if (!voter.hasVoted) {
            voterList.push(msg.sender);
            voter.hasVoted = true;
        }

        topics[topicId].options[optionId].voteCount += 1;
        voter.voteCount += 1;
        voter.choices[topicId][optionId] += 1;
        totalPool += msg.value;

        emit VoteCast(msg.sender, topicId, optionId, msg.value);
    }

    function finalizeVoting() external onlyAdmin {
        require(block.timestamp >= votingEndTime, "Voting is not yet ended");
        require(!rewardsDistributed, "Rewards already distributed");

        uint maxVotes = 0;
        for (uint t = 0; t < topics.length; t++) {
            for (uint o = 0; o < topics[t].options.length; o++) {
                if (topics[t].options[o].voteCount > maxVotes) {
                    maxVotes = topics[t].options[o].voteCount;
                    winningTopicId = t;
                    winningOptionId = o;
                }
            }
        }

        if (isRewardEnabled && maxVotes > 0) {
            uint rewardPool = (totalPool * rewardPercentage) / 100;
            uint winningVoters = topics[winningTopicId].options[winningOptionId].voteCount;
            uint rewardPerVoter = rewardPool / winningVoters;

            for (uint i = 0; i < voterList.length; i++) {
                address voterAddr = voterList[i];
                Voter storage voter = voters[voterAddr];
                uint voterWinningVotes = voter.choices[winningTopicId][winningOptionId];
                if (voterWinningVotes > 0) {
                    uint totalReward = rewardPerVoter * voterWinningVotes;
                    payable(voterAddr).transfer(totalReward);
                }
            }

            emit RewardsDistributed(winningTopicId, winningOptionId, rewardPerVoter);
        }
        rewardsDistributed = true;
    }

    function startNewRound() external onlyAdmin {
        require(rewardsDistributed, "Must finalize previous round first");
        require(block.timestamp >= votingEndTime + COOLDOWN, "Cooldown period not over");

        for (uint i = 0; i < voterList.length; i++) {
            address voterAddr = voterList[i];
            Voter storage voter = voters[voterAddr];
            voter.hasVoted = false;
            voter.voteCount = 0;
            for (uint t = 0; t < topics.length; t++) {
                for (uint o = 0; o < topics[t].options.length; o++) {
                    voter.choices[t][o] = 0;
                }
            }
        }
        delete voterList;
        delete topics;
        totalPool = 0;
        rewardsDistributed = false;
        winningTopicId = 0;
        winningOptionId = 0;
        votingStartTime = block.timestamp;
        votingEndTime = block.timestamp + VOTING_DURATION;

        emit NewRoundStarted(votingStartTime);
    }

    function getTopic(uint topicId) external view returns (string memory title, uint optionCount) {
        require(topicId < topics.length, "Invalid topic ID");
        return (topics[topicId].title, topics[topicId].options.length);
    }

    function getOption(uint topicId, uint optionId) external view returns (string memory name, uint voteCount) {
        require(topicId < topics.length, "Invalid topic ID");
        require(optionId < topics[topicId].options.length, "Invalid option ID");
        Option storage option = topics[topicId].options[optionId];
        return (option.name, option.voteCount);
    }

    function getVoterChoice(address voter, uint topicId, uint optionId) external view onlyAdmin returns (uint) {
        return voters[voter].choices[topicId][optionId];
    }

    function getVoterCount() external view returns (uint) {
        return voterList.length;
    }

    function getTopicCount() external view returns (uint) {
        return topics.length;
    }

    function withdraw() external onlyAdmin {
        require(rewardsDistributed, "Rewards must be distributed first");
        payable(admin).transfer(address(this).balance);
    }
}