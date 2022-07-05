// contract for applying with 2 nominees to vouch your application to be soul bound.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "lib/solmate/src/tokens/ERC721.sol";
import "./Registry.sol";

contract Nominate {
    ERC721 soulBound;
    Registry registry;

    struct Nominee {
        address[1] vouches;
    }

    mapping(address => Nominee) nominees;

    function nominate(address nominee) public {
        require(soulBound.balanceOf(msg.sender) > 0, "No soul bound to nominate");
        require(registry._isBanished(msg.sender) == false, "Banished ones cannot nominate");
        if (nominees[nominee].vouches.length == 0) {
            nominees[nominee].vouches[0] = msg.sender;
        } else {
            require(nominees[nominee].vouches[0] != msg.sender, "You can't nominate twice");
            nominees[nominee].vouches[1] = msg.sender;
        }
    }

    //API to check if address is nominated
    function _isNominated(address nominee) public view returns (bool) {
        return nominees[nominee].vouches.length > 1;
    }

    function _getVouches(address nominee) public view returns (address[1] memory) {
        address[1] memory _v = nominees[nominee].vouches;
       return _v;
    }
}
