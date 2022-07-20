// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "lib/forge-std/src/Test.sol";

import {Registry} from "../src/Registry.sol";

contract RegistryTest is DSTest {
    Registry registry;
    Vm vm;
    address bob = address(0x1);
    address alice = address(0x2);

    function setUp() public {
        registry = new Registry();
    }

    function testBind() public {
        registry.bind();
        assertTrue(registry.getState(address(this)));
    }

    // function testGet() public {
    //     sampleContract.func2(1337);
    // }
}
