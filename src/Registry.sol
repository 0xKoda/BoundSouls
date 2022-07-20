//Quick view function for fast soul bound status check API.
// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Registry {
    struct soul {
        address[] noms;
        uint256 bound; //timestamp of bound to allow filtering of wizards
    }

    mapping(address => soul) souls;
    mapping(address => bool) wizards;
    mapping(address => bool) banished;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    /// State Mutate Functions ///
    function nom(address c) public onlyBound {
        require(banished[c] != true, "we musnt bother the banished ones...");
        souls[c].noms.length > 1 ? souls[c].noms[0] = msg.sender : souls[c].noms[1] = msg.sender;
        souls[c].noms.length + 1;
    }

    function banish(address c) public {
        require(isWizard(msg.sender), "only a wizard may banish..");
        delete souls[c];
        banished[c] = true;
    }

    function bind() public returns (bool) {
        // require(souls[u].noms.length > 1, "must be nominated");
        require(!banished[address(msg.sender)], "banished may not bind");
        souls[address(this)].bound = block.timestamp;
        return true;
    }

    function ascend() public onlyBound returns (bool) {
        address u = msg.sender;
        require(souls[u].bound < block.timestamp + 96000, "not enough xp");
        wizards[u] = true;
        return true;
    }

    /// View Functions ///

    function isWizard(address w) public view returns (bool) {
        return wizards[w];
    }

    function getState(address s) public view returns (bool) {
        if (address(msg.sender) == owner) {
            return true;
        }
        return souls[s].bound != 0;
    }

    // Modifiers //
    modifier onlyBound() {
        require(getState(address(msg.sender)), "not bound");
        _;
    }
}
