// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "lib/solmate/src/tokens/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import "./Nominate.sol";

contract SoulBound is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Nominate _nominate;

    constructor() public ERC721("SoulBound", "SB") {}

    // A function our user will hit to get their NFT.
    function bindSoul() public {
        require(_nominate._isNominated(msg.sender), "You are not nominated");
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();
        //What If I just make the token ID the address of the sender?
        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(newItemId, address(msg.sender).toString());

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
