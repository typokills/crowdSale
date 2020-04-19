pragma solidity >=0.4.21;

contract ChinToken{
    mapping (address => uint256) tokenBalance;
    uint256 totalSupply = 0;
    address tokenIssuer;
    mapping (address => bool) approval;
    mapping (address => address) approvalAcc;
    
    constructor() public{
        tokenIssuer = msg.sender; //Only token issuer can create new tokens
    }

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
        require(msg.sender == tokenIssuer);
        tokenBalance[msg.sender] = _startingSupply;
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
        require(approvalAcc[_giver] == msg.sender) 
        require(approval[_giver] == true); //_giver must give prior approval for transaction
        require(amt > 0); //ensures sender cannot steal

        tokenBalance[_giver] -= amt;
        tokenBalance[_receiver] += amt;

        approval[_giver] = false; //Approval only for one transaction  
    }

    //Function for user to give prior approval for 3rd party transaction
    function giveApproval (bool choice, address thirdPty) public {
        approval[msg.sender] = choice;
        approvalAcc[msg.sender] = thirdPty;
    }


    // For third party to check before making 3rd party transfer
    function viewApproval(address _account) public view returns (bool){
        return approval[_account];
    }
    
    function getIssuer() public view returns (address){
        return tokenIssuer;
    }
    
}