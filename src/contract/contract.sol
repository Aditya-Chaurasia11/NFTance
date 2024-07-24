// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenid;
    Counters.Counter private _tokens_sold;
    address owner;

    struct NFT_data {
        uint256 tokenid;
        address owner;
        address sender;
        uint256 price;
        bool outforsale;
        string videoURL;
        string videoName;
        string videoDescription;
        string videoCategory;
    }

    mapping(uint256 => NFT_data) public map;

    constructor() ERC721("NFTMarketplace", "NFTMP") {
        owner = msg.sender;
    }

    function currentid() public view returns (uint256) {
        return _tokenid.current();
    }

    function items_sold() public view returns (uint256) {
        return _tokens_sold.current();
    }

    function createNFT(
        string memory tokenURI,
        uint256 price,
        string memory videoURL,
        string memory videoName,
        string memory videoDescription,
        string memory videoCategory
    ) public returns (uint256) {
        uint256 currentTokenId = _tokenid.current();
        _mint(msg.sender, currentTokenId);
        _setTokenURI(currentTokenId, tokenURI);
        Mapitem(currentTokenId, price, videoURL, videoName, videoDescription, videoCategory);
        _tokenid.increment();
        return currentTokenId;
    }

    function Mapitem(
        uint256 _id,
        uint256 price,
        string memory videoURL,
        string memory videoName,
        string memory videoDescription,
        string memory videoCategory
    ) internal {
        _transfer(msg.sender, address(this), _id);
        map[_id] = NFT_data(
            _id,
            address(this),
            msg.sender,
            price,
            true,
            videoURL,
            videoName,
            videoDescription,
            videoCategory
        );
    }

    function getNFTDetails(uint256 tokenId) public view returns (
        uint256,
        address,
        address,
        uint256,
        bool,
        string memory,
        string memory,
        string memory,
        string memory
    ) {
        NFT_data memory nft = map[tokenId];
        return (
            nft.tokenid,
            nft.owner,
            nft.sender,
            nft.price,
            nft.outforsale,
            nft.videoURL,
            nft.videoName,
            nft.videoDescription,
            nft.videoCategory
        );
    }

    function resale(uint256 _id) public {
        require(!map[_id].outforsale, "already up for sale");
        require(map[_id].owner == msg.sender, "caller is not the owner");
        _transfer(msg.sender, address(this), _id);
        map[_id].owner = address(this);
        map[_id].outforsale = true;
        if (_tokens_sold.current() > 0) {
            _tokens_sold.decrement();
        }
    }

    function setprice(uint256 id, uint256 price) public {
        require(map[id].sender == msg.sender, "caller is not the seller");
        map[id].price = price;
    }

    function buynft(uint256 _id) public payable {
        require(map[_id].outforsale, "NFT not for sale");
        require(msg.value == map[_id].price, "Incorrect price");
        _transfer(address(this), msg.sender, _id);
        payable(map[_id].sender).transfer(msg.value);
        map[_id].outforsale = false;
        map[_id].owner = msg.sender;
        map[_id].sender = msg.sender;
        _tokens_sold.increment();
    }

    function allmynftsnotforsale() public view returns (NFT_data[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < _tokenid.current(); i++) {
            if (map[i].owner == msg.sender && !map[i].outforsale) {
                count++;
            }
        }
        uint256 index = 0;
        NFT_data[] memory temp = new NFT_data[](count);
        for (uint256 i = 0; i < _tokenid.current(); i++) {
            if (map[i].owner == msg.sender && !map[i].outforsale) {
                temp[index] = map[i];
                index++;
            }
        }
        return temp;
    }

    function allmynfts() public view returns (NFT_data[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < _tokenid.current(); i++) {
            if (map[i].sender == msg.sender) {
                count++;
            }
        }
        uint256 index = 0;
        NFT_data[] memory temp = new NFT_data[](count);
        for (uint256 i = 0; i < _tokenid.current(); i++) {
            if (map[i].sender == msg.sender) {
                temp[index] = map[i];
                index++;
            }
        }
        return temp;
    }

    function nftsforsale() public view returns (NFT_data[] memory) {
        uint256 count = _tokenid.current() - _tokens_sold.current();
        uint256 q = 0;
        NFT_data[] memory temp = new NFT_data[](count);
        for (uint256 i = 0; i < _tokenid.current(); i++) {
            if (map[i].owner == address(this) && map[i].outforsale) {
                temp[q] = map[i];
                q++;
            }
        }
        return temp;
    }

    function stopsale(uint256 _id) public {
        require(map[_id].outforsale, "not in sale");
        _transfer(address(this), msg.sender, _id);
        map[_id].owner = msg.sender;
        map[_id].outforsale = false;
    }
}
