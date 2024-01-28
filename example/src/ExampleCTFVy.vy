# @version 0.3.0

"""A simple vault contract

This contract implements a simple vault where users can deposit and withdraw
ether.
"""

import interfaces.IExampleCTFVy as IExampleCTFVy

implements: IExampleCTFVy

userBalances: public(HashMap[address, uint256])

event Deposit:
    src: indexed(address)
    amount: uint256

event Transfer:
    src: indexed(address)
    dst: indexed(address)
    amount: uint256

event Withdrawal:
    src: indexed(address)
    amount: uint256

@external
@payable
def deposit():
    self.userBalances[msg.sender] += msg.value
    log Deposit(msg.sender, msg.value)

@external
@nonreentrant("withdraw")
def transfer(to: address, amount: uint256):
    if self.userBalances[msg.sender] >= amount:
        self.userBalances[msg.sender] -= amount
        self.userBalances[to] += amount
        log Transfer(msg.sender, to, amount)

@external
@nonreentrant("withdraw")
def withdrawAll():
    _balance: uint256 = self.userBalances[msg.sender]
    assert _balance > 0, "Insufficient balance"

    raw_call(msg.sender, b"", value=_balance)

    self.userBalances[msg.sender] = 0
    log Withdrawal(msg.sender, _balance)

@external
@view
def getBalance() -> uint256:
    return self.balance

@external
@view
def isSolved() -> bool:
    return self.balance == 0