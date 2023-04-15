// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PrivateNFT is ERC721, Ownable {
    mapping(address => bool) private _allowedViewers;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function mint(address to, uint256 tokenId) public onlyOwner {
        _mint(to, tokenId);
    }

    function allowViewer(address viewer) public onlyOwner {
        _allowedViewers[viewer] = true;
    }

    function disallowViewer(address viewer) public onlyOwner {
        _allowedViewers[viewer] = false;
    }

    function isViewerAllowed(address viewer) public view returns (bool) {
        return _allowedViewers[viewer];
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_allowedViewers[msg.sender], "Caller is not allowed to view this NFT");
        return super.tokenURI(tokenId);
    }
}
