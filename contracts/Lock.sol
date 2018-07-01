pragma solidity ^0.4.21;


contract Lock {

    struct User {
        uint releaseDate;
        uint value;
    }

    mapping (address => User) public balances;
    address public donationAddress;

    constructor public {
        balances[msg.sender].value = 0;
    }

    function lockValue(uint _releaseDate) public payable {
        require(balances[msg.sender].value == 0);

        balances[msg.sender].value = msg.value;
        balances[msg.sender].releaseDate = _releaseDate;
    }

    function lockValueAndDonate(uint _releaseDate) public payable {
        require(balances[msg.sender].value == 0);

        uint donationValue = msg.value / 200; // 0.5% donation
        uint valueAfterDonation = sub(msg.value, donationValue);

        balances[donationAddress].value += donationValue;
        balances[msg.sender].value = valueAfterDonation;
        balances[msg.sender].releaseDate = _releaseDate;
    }

    function withdraw() public {
        require(now > balances[msg.sender].releaseDate && balances[msg.sender].value > 0);

        uint payout = balances[msg.sender].value;
        balances[msg.sender].value = 0;
        balances[msg.sender].releaseDate = 0;
        msg.sender.transfer(payout);
    }

    function sub(uint a, uint b) internal pure returns (uint) {
        require(b <= a);
        return a - b;
    }

}
