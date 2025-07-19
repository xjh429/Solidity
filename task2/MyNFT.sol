// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {
        tokenCounter = 0;
    }

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter += 1;
        return newTokenId;
    }
}

/*
### 2. 准备图文数据并上传 IPFS
1. 准备图片 ：选择一张图片，上传到 IPFS（推荐用 Pinata、NFT.Storage 或 Infura）。
2. 获取图片 IPFS 链接
ipfs://bafybeigwusmhuts4yqofaoxb3rndnaahzaixyvwfjb6hdv3r6mh4kjbfty
3. 创建元数据 JSON 文件 ，内容参考 OpenSea 标准：
```
{
  "name": "我的第一个NFT",
  "description": "这是我学习 Solidity 铸造的第一个NFT。",
  "image": "ipfs://bafybeigwusmhuts4yqofaoxb3rndnaahzaixyvwfjb6hdv3r6mh4kjbfty"
}
```
4. 上传 JSON 文件到 IPFS ，获得元数据链接
ipfs://bafkreiga46qtrgj6g26cuwsllist766f3aeertg7w54xywruyxizsqosqm
### 3. 部署合约到 Sepolia 测试网
- 在 Remix IDE 中导入合约代码，连接 MetaMask 钱包（切换到 Sepolia 测试网）。
- 编译并部署合约，记录合约地址。
### 4. 铸造 NFT
- 在 Remix 的合约交互界面，调用 mintNFT 方法：
  - recipient：你的钱包地址
  - tokenURI：上一步获得的元数据 IPFS 链接（如 ipfs://Qm.../metadata.json ）
- 在 MetaMask 中确认交易。
### 5. 查看 NFT
- 打开 Sepolia Etherscan ，输入你的钱包地址，查看 NFT。
- 也可以在 OpenSea 测试网（ testnets.opensea.io ）连接钱包，查看 NFT 展示效果。
*/
