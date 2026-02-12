// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
// Specifies the Solidity compiler version required to compile this contract



// Import ERC721URIStorage from OpenZeppelin
// This extension allows us to store a tokenURI (metadata link) for each NFT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


// Import Ownable contract
// This gives the contract an owner and allows us to restrict functions using onlyOwner
import "@openzeppelin/contracts/access/Ownable.sol";



// Define the smart contract
// The contract inherits from:
// 1. ERC721URIStorage (NFT functionality + metadata storage)
// 2. Ownable (access control functionality)
contract AlexTokenTwo is ERC721URIStorage, Ownable {

    // This variable keeps track of the next token ID to be minted
    uint256 public tokenCounter;


    // This constant sets a maximum supply of 500 NFTs
    // "constant" means it cannot be changed after deployment
    uint256 public constant MAX_SUPPLY = 500;


    // Constructor runs only once when the contract is deployed
    constructor() 
        ERC721("Alex Token Two", "ATT2")  // Sets token name and symbol
        Ownable(msg.sender)               // Sets the deployer as contract owner
    {
        // Start token IDs from 1 instead of 0
        tokenCounter = 1;
    }



    // Function to mint a new NFT
    // recipient = address that will receive the NFT
    // _tokenURI = IPFS metadata link
    function mintNFT(address recipient, string memory _tokenURI)
        public
        onlyOwner                 // Only contract owner can mint
        returns (uint256)         // Returns the new token ID
    {

        // Ensure we do not exceed maximum supply
        require(tokenCounter <= MAX_SUPPLY, "Maximum supply reached");


        // Assign current counter value as new token ID
        uint256 newTokenId = tokenCounter;


        // Mint the NFT safely to the recipient address
        _safeMint(recipient, newTokenId);


        // Attach metadata URI (IPFS link) to the token
        _setTokenURI(newTokenId, _tokenURI);


        // Increment counter for next mint
        tokenCounter++;


        // Return the token ID that was just created
        return newTokenId;
    }
}
