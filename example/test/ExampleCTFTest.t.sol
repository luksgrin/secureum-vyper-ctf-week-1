// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ExampleCTFDeployer} from "script/ExampleCTFDeployer.s.sol";
import {ExampleCTFSolutionDeployer} from "script/ExampleCTFSolutionDeployer.s.sol";
import {ExampleCTFVySolution} from "src/ExampleCTFVySolution.sol";
import {IExampleCTFVy} from "src/interfaces/IExampleCTFVy.sol";

/// ExampleCTFTest to showcase the solution to the ExampleCTF
contract ExampleCTFTest is Test, ExampleCTFDeployer, ExampleCTFSolutionDeployer {
    IExampleCTFVy public vyperSecureumCTF;
    ExampleCTFVySolution public solutionContract;

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(ExampleCTFDeployer, ExampleCTFSolutionDeployer) {

        ExampleCTFDeployer.setUp();

        vyperSecureumCTF = IExampleCTFVy(
            deployExampleCTF()
        );

        solutionContract = deploySolution(
            address(vyperSecureumCTF)
        );

        vm.deal(address(vyperSecureumCTF), 1 ether);

    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_unsolved() external {
        assertFalse(vyperSecureumCTF.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_solved() external {
        solutionContract.solve{value: 0.1 ether}();

        assertTrue(vyperSecureumCTF.isSolved());
    }
}
