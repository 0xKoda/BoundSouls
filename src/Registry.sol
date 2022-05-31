//Quick view function for fast soul bound status check API.
// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "lib/solmate/src/tokens/ERC721.sol";

contract Registry {
    struct BoundOnes {
        address owner;
        uint256 tokenId;
        address[1] nominees;
        uint256 mintTime;
    }

    ERC721 SoulBound;
    mapping(address => uint256) boundSouls;
    mapping(address => BoundOnes) boundSoulsInfo;
    mapping(address => uint256) theBanished;
    uint256 bindings = 0;

    //Binds the msg.sender to the given soul.
    function bind() public {
        require(SoulBound.balanceOf(msg.sender) > 0, "No soul bound to bind");
        boundSouls[msg.sender] = bindings++;
        bindings++;
    }

    // Checks if given address in Soul Bound
    function getBound(address addr) public view returns (uint256) {
        return boundSouls[addr];
    }

    function banish(address addr) public {
        require(boundSouls[addr] != 0, "Not bound");
        theBanished[addr] = block.timestamp;
        boundSouls[addr] = 0;
    }

    // API to check if banished
    function _isBanished(address addr) public view returns (bool) {
        return theBanished[addr] != 0;
    }
}
