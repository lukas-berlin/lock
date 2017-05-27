pragma solidity ^0.4.11;


contract lock {
    struct user {
        uint releaseDate;
        uint value;
    }
    mapping (address => user) public balance;

    function invest  (uint _releaseDate) payable {
        require(balance[msg.sender].value == 0);
        balance[msg.sender].value=msg.value;
        balance[msg.sender].releaseDate=_releaseDate;

    }
    function withdraw ()  {
        require(now > balance[msg.sender].releaseDate && balance[msg.sender].value>0);

        uint payout = balance[msg.sender].value;
        balance[msg.sender].value=0;
        balance[msg.sender].releaseDate=0;
        msg.sender.transfer(payout);

    }




}
