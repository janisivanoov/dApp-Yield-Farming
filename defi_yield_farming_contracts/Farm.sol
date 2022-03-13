pragma solidity ^0.8.0;

import "./dAppToken.sol";
import "./DaiCoin.sol";

contract TokenFarm{
    string public name = "dApp TF(Token Farm)";
    address public owner;
    address[] public staker;
    dAppToken public dToken;
    DaiCoin public diToken;
    
    mapping(address => uint) public stakingBalanace;
    mapping(address => bool) public staked;
    mapping(address => bool) public staking;

    constructor(DappToken _dToken, DaiToken _diToken) public {
        owner = msg.sender;
        dToken = _dToken;
        diToken = _diToken;
    }

    function stake(uint _amout) public {
        diToken.fransferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalanace[msg.sender] + _amount;
        if(!staked[msg.sender]){
            staker.push(msg.sender);
        }
        staking[msg.sender] = true;
        staked[msg.sender] = true;
    }

    function unstakeTk() public {
        uint balance = stakingBalanace[msg.sender];
        require(balance > 0, "You cannot stake 0");
        diToken.transfer(msg.sender, balance);
        stakingBalanace[msg.sender] = 0;
        staking[msg.sender] = true;
    }

    function issueTk() public {
        require(msg.sender == owner, "Function caller suppose to be owner");
        for(uint i = 0; i < staker.length; i++){
            address recipient = staker[i];
            uint balance = stakingBalanace[recipient];
            if(balance > 0){
                dToken.transfer(recipient, balance);
            }
        }
    }
}