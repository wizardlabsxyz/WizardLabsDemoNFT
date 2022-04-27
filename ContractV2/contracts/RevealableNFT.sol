// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

/**  _    _ _                  _ _           _         
 *  | |  | (_)                | | |         | |        
 *  | |  | |_ ______ _ _ __ __| | |     __ _| |__  ___ 
 *  | |/\| | |_  / _` | '__/ _` | |    / _` | '_ \/ __|
 *  \  /\  / |/ / (_| | | | (_| | |___| (_| | |_) \__ \
 *   \/  \/|_/___\__,_|_|  \__,_\_____/\__,_|_.__/|___/
 *
 * 🧙 https://wizardlabs.xyz/ 🧙
*/ 

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * Set hidden URI on constructor
 * Paused on creation
 * Setting revealed metadata uri also reveals the collection
 * Cost is immutable
 * Max supply is immutable
 */
contract RevealableNFT is ERC721, Ownable {
  using Strings for uint256;
  using Counters for Counters.Counter;

  Counters.Counter private supply;

  // formatted as ... ipfs://__CID__/
  string public hiddenMetadataUri;
  string public revealedMetadataUri;
  string private uriSuffix = ".json";
  
  uint256 public cost = 0.01 ether;
  uint256 public maxSupply = 10000;
  uint256 public maxMintAmountPerTx = 5;

  bool public paused = true;
  bool public revealed = false;

  constructor(string memory _name,
              string memory _symbol,
              string memory _hiddenMetadataUri) ERC721(_name, _symbol) {
    setHiddenMetadataUri(_hiddenMetadataUri);
  }

  modifier mintCompliance(uint256 _mintAmount) {
    require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, "Invalid mint amount!");
    require(supply.current() + _mintAmount <= maxSupply, "Max supply exceeded!");
    _;
  }

  function totalSupply() public view returns (uint256) {
    return supply.current();
  }

  function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) {
    require(!paused, "The contract is paused!");
    require(msg.value >= cost * _mintAmount, "Insufficient funds!");

    _mintLoop(msg.sender, _mintAmount);
  }

  function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

    if (revealed == false) {
      return getFullMetadataUri(hiddenMetadataUri, _tokenId);
    }

    return getFullMetadataUri(revealedMetadataUri, _tokenId);
  }

  function mintForAddress(uint256 _mintAmount, address _receiver) public mintCompliance(_mintAmount) onlyOwner {
    _mintLoop(_receiver, _mintAmount);
  }

  function setMaxMintAmountPerTx(uint256 _maxMintAmountPerTx) public onlyOwner {
    maxMintAmountPerTx = _maxMintAmountPerTx;
  }

  function setHiddenMetadataUri(string memory _hiddenMetadataUri) public onlyOwner {
    hiddenMetadataUri = _hiddenMetadataUri;
  }

  function setRevaledMetadataUri(string memory _revealedMetadataUri) public onlyOwner {
    revealedMetadataUri = _revealedMetadataUri;
    revealed = true;
  }

  function setPaused(bool _state) public onlyOwner {
    paused = _state;
  }

  function _mintLoop(address _receiver, uint256 _mintAmount) internal {
    for (uint256 i = 0; i < _mintAmount; i++) {
      supply.increment();
      _safeMint(_receiver, supply.current());
    }
  }

  function getFullMetadataUri(string memory _uri, uint256 _tokenId) internal view returns (string memory) {
    return bytes(_uri).length > 0
        ? string(abi.encodePacked(_uri, _tokenId.toString(), uriSuffix))
        : "";
    }
 }