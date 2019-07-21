pragma solidity ^0.5.0;

contract BDUmembersLedger {
    address public owner;
    mapping(address=>bool) public members;
    
    constructor () public{
        owner == msg.sender; 
    }
    
    function addMember(address member) public{
        require(msg.sender==owner);
        members[member] = true;
    }
    
    function changeOwner(address newOwner,uint levels) public returns (bool){
        require(levels==0);
        owner = newOwner;
    }
    
    function isMember(address _address) public view returns(bool){
        return(members[_address]);
    }
}

contract mLOwner{
    address public sub; //membership Ledger
    
    address public owner;

    
    constructor(address subLedgerAddress) public {
        sub = subLedgerAddress;
    }
    
    function addMember(address member) public{
        require(owner==msg.sender);
        mLOwner(sub).addMember(member);
    }
    
    function changeOwner(address newOwner, uint levels) public {
        require(msg.sender==owner);
        if (levels==0){
            owner = newOwner;
        } else {
            mLOwner(sub).changeOwner(newOwner,--levels);
        }
        
    }
    
    function isMember(address _address) public view returns(bool){
        return(mLOwner(sub).isMember(_address));
    }
    
    
}



contract Owner1 is mLOwner{
    
    
    
    constructor(address sub) mLOwner(sub) public{
        owner=msg.sender;
    }
    
    struct Identity{
        mapping(address => bool) memberSignatures; 
        uint signatureCount;
    }
    mapping(address=>Identity) identities;
    
    
    
    function attestIdentity(address attestee) public{
        require(isMember(attestee));
        require(!identities[attestee].memberSignatures[msg.sender]);
        identities[attestee].memberSignatures[msg.sender] = true;
        identities[attestee].signatureCount++;
    }
}

contract Owner2 is Owner1{
    
     constructor(address sub) Owner1(sub) public{
        owner=msg.sender;
    }
    mapping(address=>dev) public devs; 
   
    struct dev{
        mapping(address=>uint) ratings;
        uint rateCount;
        uint score;
    }
    function rateDev(address _dev,uint rating) public{
        require(0<rating && rating<=5);
        
        devs[_dev].score += rating;

        if (devs[_dev].ratings[msg.sender] == 0){
            devs[_dev].rateCount++;

        } else{
            devs[_dev].ratings[msg.sender]=rating;
            uint oldRating = devs[_dev].ratings[msg.sender];
            devs[_dev].score -= oldRating;
        }
      
    }
    
    //Rating out of 5000000
    function getRating(address _dev) public view returns(uint){
        uint score = devs[_dev].score;
        uint rateCount = devs[_dev].rateCount;
        return(score*1000000/rateCount);
    }
    
}
