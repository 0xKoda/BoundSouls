//Quick view function for fast soul bound status check API.
// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Registry {
    struct soul {
        address[] noms;
        bool bound;
    }

mapping(address => soul) souls;
mapping(address => bool) wizards;
mapping(address => bool) banished;


function getState(address s) public view returns (bool){
    return souls[s].bound;
}

function nom(address c) public {
    require(banished[c] != true, "we musnt bother the banished ones...");
    require(souls[address(msg.sender)].bound, "not bound");
    souls[c].noms.length > 1 ? souls[c].noms[0] = msg.sender : souls[c].noms[1] = msg.sender;
    souls[c].noms.length + 1;
}

function banish(address c) public {
    require(wizards[msg.sender] == true, "only a wizard may banish..");
    delete souls[c];
    banished[c] = true;
}


}