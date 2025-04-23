// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInteger {
    // 罗马字符到数值的映射
    mapping(bytes1 => uint256) private romanValues;

    constructor() {
        // 初始化罗马数字对应值
        romanValues['I'] = 1;
        romanValues['V'] = 5;
        romanValues['X'] = 10;
        romanValues['L'] = 50;
        romanValues['C'] = 100;
        romanValues['D'] = 500;
        romanValues['M'] = 1000;
    }

    // 罗马数字转整数函数
    function romanToInt(string memory s) public view returns (uint256) {
        bytes memory roman = bytes(s);
        uint256 total = 0;
        uint256 prevValue = 0;
        
        for (uint256 i = roman.length; i > 0 ; i--) {
            // 当前字符的值
            uint256 currentValue = romanValues[roman[i-1]];
            
            if (currentValue < prevValue) {
                total -= currentValue;
            } else {
                total += currentValue;
            }
            
            prevValue = currentValue;
        }
        
        return total;
    }
}
