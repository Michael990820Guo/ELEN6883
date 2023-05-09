// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct NFT {
        uint256 tokenId;
        string name;
        string description;
        address owner;
        uint256 salePrice;
    }

    mapping(uint256 => NFT) public nfts;

    constructor() ERC721("NFTMarketplace", "NFTM") {}

    function createNFT(uint256 tokenId, string memory name, string memory description, string memory tokenURI) public {
        require(!_exists(tokenId), "NFT with this token ID already exists");
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        NFT memory nft = NFT(tokenId, name, description, msg.sender, 0);
        nfts[tokenId] = nft;
    }

    function transferNFT(uint256 tokenId, address to) public {
        require(nfts[tokenId].owner == msg.sender, "Caller is not the owner");
        require(to != address(0), "Invalid recipient address");

        _transfer(msg.sender, to, tokenId);
        nfts[tokenId].owner = to;
    }

    function listNFTForSale(uint256 tokenId, uint256 salePrice) public {
        require(nfts[tokenId].owner == msg.sender, "Caller is not the owner");
        require(salePrice > 0, "Sale price must be greater than 0");

        nfts[tokenId].salePrice = salePrice;
    }

    function removeNFTFromSale(uint256 tokenId) public {
        require(nfts[tokenId].owner == msg.sender, "Caller is not the owner");

        nfts[tokenId].salePrice = 0;
    }

    function purchaseNFT(uint256 tokenId) public payable {
        NFT memory nft = nfts[tokenId];
        require(nft.salePrice > 0, "NFT is not for sale");
        require(msg.value >= nft.salePrice, "Insufficient funds");

        address previousOwner = nft.owner;
        payable(previousOwner).transfer(nft.salePrice);

        _transfer(previousOwner, msg.sender, tokenId);
        nfts[tokenId].owner = msg.sender;
        nfts[tokenId].salePrice = 0;
    }

    function getNFT(uint256 tokenId) public view returns (NFT memory) {
        return nfts[tokenId];
    }
}
