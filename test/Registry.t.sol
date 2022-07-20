// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "lib/forge-std/src/Test.sol";

import {Registry} from "../src/Registry.sol";

contract RegistryTest is DSTestPlus {
    Registry registry;

    function setUp() public {
        registry = new Registry();
        
    }

    function testGetBound() public {
        registry.getBound(addr(accounts(1)));
    }

    function testFunc2() public {
        sampleContract.func2(1337);
    }
}