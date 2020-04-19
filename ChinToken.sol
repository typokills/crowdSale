pragma solidity >=0.4.21;

contract ChinToken{
    mapping (address => uint256) tokenBalance;
    uint256 totalSupply = 0;
    address tokenIssuer;
    mapping (address => bool) approval;
    
    
    //Can only check balance and everyone can use it
    function getBalance(address _account) public view returns (uint256){
        return tokenBalance[_account];
    }
    
    //View total number of tokens
    function viewSupply() public view returns (uint256){
        return totalSupply;
    }

    //Creates the initial pool of tokens
    function IssueTokens(uint256 _startingSupply) public{
        //all of it goes into  contract creator's wallet
        tokenBalance[msg.sender] = _startingSupply;
        tokenIssuer = msg.sender;
        totalSupply = _startingSupply;
    }

    //Transfer tokens
    function transferTokens(address _receiver, uint256 amt) public{
        require(tokenBalance[msg.sender] >= amt);
        require(amt > 0); //ensures that sender cannot steal
        tokenBalance[msg.sender] -= amt;
        tokenBalance[_receiver] += amt;
    }
    
    //Third party transfer of tokens, Can only be used by issuer of the tokens
    function transferFrom(address _giver, address _receiver, uint256 amt) public {
        require(tokenBalance[_giver] >= amt);
        require(approval[_giver] == true); //_giver must give prior approval for transaction
        require(amt > 0); //ensures sender cannot steal

        tokenBalance[_giver] -= amt;
        tokenBalance[_receiver] += amt;

        approval[_giver] = false; //Approval only for one transaction  
    }
    
    
}