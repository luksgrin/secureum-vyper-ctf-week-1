pragma solidity ^0.8.10;

interface IExampleCTFVy {
    event Deposit(address indexed src, uint256 amount);
    event Transfer(address indexed src, address indexed dst, uint256 amount);
    event Withdrawal(address indexed src, uint256 amount);

    function deposit() external payable;
    function getBalance() external view returns (uint256);
    function isSolved() external view returns (bool);
    function transfer(address to, uint256 amount) external;
    function userBalances(address arg0) external view returns (uint256);
    function withdrawAll() external;
}