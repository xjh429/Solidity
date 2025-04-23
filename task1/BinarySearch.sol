// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch{
    function search(uint[] memory arr, uint target) public pure returns (uint) {
        uint low = 0;
        uint high = arr.length;

        while (low < high) {
            uint mid = low + (high - low) / 2;  // 防止溢出
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return type(uint256).max;  // 使用最大值表示未找到
    }
}
