// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract BeggingContract{

    address public owner;
    mapping(address => uint256) public donations;
    uint256 public donationEndTime;
    uint256 public constant DONATION_PERIOD = 7 days; // 捐赠时间限制为7天
    // 排行榜：固定长度为3
    address[3] public topDonors; // 前3名捐赠者地址
    uint256[3] public topAmounts; // 前3名捐赠金额

    // 捐赠事件
    event Donation(address indexed donor, uint256 amount);
    // 提款事件
    event Withdrawal(address indexed owner, uint256 amount);

    // 构造函数，设置所有者和捐赠截止时间
    constructor() {
        owner = msg.sender;
        donationEndTime = block.timestamp + DONATION_PERIOD;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, unicode"只有合约所有者可以调用此函数");
        _;
    }

    modifier onlyDuringDonationPeriod() {
        require(block.timestamp <= donationEndTime, unicode"捐赠时间已结束");
        _;
    }

    function donate() public payable onlyDuringDonationPeriod {
        require(msg.value > 0, unicode"捐赠金额必须大于0");

        // 更新捐赠金额
        donations[msg.sender] += msg.value;

        // 更新排行榜
        updateTopDonors(msg.sender, donations[msg.sender]);

        // 触发捐赠事件
        emit Donation(msg.sender, msg.value);
    }

   function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, unicode"没有可提取的资金");

        // 使用 transfer 转账给所有者
        payable(owner).transfer(amount);

        // 触发提款事件
        emit Withdrawal(owner, amount);
    }

    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }

    function getTopDonors() public view returns (address[3] memory, uint256[3] memory) {
        return (topDonors, topAmounts);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // 内部函数：更新排行榜
    function updateTopDonors(address donor, uint256 totalAmount) internal {
        // 检查是否已在排行榜中
        bool isInTop = false;
        uint256 replaceIndex = 3; // 默认不替换

        for (uint256 i = 0; i < 3; i++) {
            if (topDonors[i] == donor) {
                // 更新已有捐赠者的金额
                topAmounts[i] = totalAmount;
                isInTop = true;
                replaceIndex = i;
                break;
            } else if (totalAmount > topAmounts[i] && replaceIndex == 3) {
                // 记录需要插入的位置
                replaceIndex = i;
            }
        }

        // 如果不在排行榜中且金额大于最小值，插入
        if (!isInTop && replaceIndex < 3) {
            // 向后移动
            for (uint256 i = 2; i > replaceIndex; i--) {
                topDonors[i] = topDonors[i - 1];
                topAmounts[i] = topAmounts[i - 1];
            }
            // 插入新数据
            topDonors[replaceIndex] = donor;
            topAmounts[replaceIndex] = totalAmount;
        } else if (isInTop) {
            // 如果已在排行榜中，重新排序
            for (uint256 i = replaceIndex; i > 0; i--) {
                if (topAmounts[i] > topAmounts[i - 1]) {
                    // 交换
                    address tempDonor = topDonors[i];
                    uint256 tempAmount = topAmounts[i];
                    topDonors[i] = topDonors[i - 1];
                    topAmounts[i] = topAmounts[i - 1];
                    topDonors[i - 1] = tempDonor;
                    topAmounts[i - 1] = tempAmount;
                } else {
                    break;
                }
            }
        }
    }

}
