// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{
    // 一个mapping来存储候选人的得票数
    mapping(address => uint256) public votes;
    address[] public candidates; // 记录所有候选人
    // 一个vote函数，允许用户投票给某个候选人
    function vote(address candidate) public {
        if (votes[candidate] == 0) { // 如果是新候选人
            candidates.push(candidate);
        }
        votes[candidate] += 1;
    }
    // 一个getVotes函数，返回某个候选人的得票数
    function getVotes(address candidate) public view returns (uint256) {
        return votes[candidate];
    }
    // 一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() public {
        for(uint i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
    }
}
