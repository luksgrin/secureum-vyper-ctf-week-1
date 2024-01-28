// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ExampleCTFVySolution} from "src/ExampleCTFVySolution.sol";

contract ExampleCTFSolutionDeployer is Script {

    function setUp() public virtual {}

    function deploySolution(address victim) public returns(ExampleCTFVySolution solutionContract) {
        solutionContract = new ExampleCTFVySolution(victim);
    }

    function run(address victim) public returns(ExampleCTFVySolution) {
        vm.broadcast();
        return deploySolution(victim);
    }
}
