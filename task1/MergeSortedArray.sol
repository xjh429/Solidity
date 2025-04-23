// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    function merge(uint[] memory a, uint[] memory b) public pure returns (uint[] memory) {
        // 创建新数组，长度为a和b的长度之和
        uint[] memory c = new uint[](a.length + b.length);
        uint i = 0; // a数组的索引
        uint j = 0; // b数组的索引
        uint k = 0; // c数组的索引
        
        // 合并两个数组，直到其中一个被完全遍历
        while (i < a.length && j < b.length) {
            if (a[i] < b[j]) {
                c[k] = a[i];
                i++;
            } else {
                c[k] = b[j];
                j++;
            }
            k++;
        }
        
        // 将a数组剩余元素添加到c
        while (i < a.length) {
            c[k] = a[i];
            i++;
            k++;
        }
        
        // 将b数组剩余元素添加到c
        while (j < b.length) {
            c[k] = b[j];
            j++;
            k++;
        }
        
        return c;
    }
}
