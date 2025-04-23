// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reverse_string {
    // 反转一个字符串
    function reverseString(string memory str) public pure returns (string memory) {
        bytes memory data = bytes(str); // 将字符串转换为字节数组
        
        for (uint i = 0; i < data.length / 2; i++) {
            // 交换对称位置的字符
            bytes1 temp = data[i];
            data[i] = data[data.length - 1 - i];
            data[data.length - 1 - i] = temp;
        }
        
        return string(data); // 将字节数组转换回字符串
    }
}
