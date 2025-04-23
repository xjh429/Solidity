// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerToRoman {
    // 使用 mapping 存储关键数值映射
    mapping(uint256 => string) private valueToRoman;
    
    constructor() {
        // 初始化关键数值映射（包含减法组合）
        valueToRoman[1] = "I";
        valueToRoman[4] = "IV";
        valueToRoman[5] = "V";
        valueToRoman[9] = "IX";
        valueToRoman[10] = "X";
        valueToRoman[40] = "XL";
        valueToRoman[50] = "L";
        valueToRoman[90] = "XC";
        valueToRoman[100] = "C";
        valueToRoman[400] = "CD";
        valueToRoman[500] = "D";
        valueToRoman[900] = "CM";
        valueToRoman[1000] = "M";
    }

    // 整数转罗马数字函数
    function intToRoman(uint256 num) public view returns (string memory) {
        require(num >= 1 && num <= 3999, "Number out of range (1-3999)");
        
        // 关键数值按从大到小排序
        uint256[13] memory values = [
            uint256(1000),
            uint256(900),
            uint256(500),
            uint256(400),
            uint256(100),
            uint256(90),
            uint256(50),
            uint256(40),
            uint256(10),
            uint256(9),
            uint256(5),
            uint256(4),
            uint256(1)
        ];
        
        string memory result;
        
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                result = string.concat(result, valueToRoman[values[i]]);
                num -= values[i];
            }
        }
        
        return result;
    }
}
