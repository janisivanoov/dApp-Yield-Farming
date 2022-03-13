pragma solidity ^0.8.0;

contract Migrations{
    address public owner;
    uint public last_migration_which_is_completed;

    constructor() public{
        owner = msg.sender;
    }

    modifier restricted(){
        if(msg.sender == owner) _;
    }

    function setAsCompleted(uint completed) public restricted{
        last_migration_which_is_completed = completed;
    }

    function upgrade(address _address) public restricted{
        Migrations upgrade = Migrations(_address);
        upgrade.setAsCompleted(last_migration_which_is_completed);
    }
}