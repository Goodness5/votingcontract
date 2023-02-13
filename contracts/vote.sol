// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/// @author KOLAPO GOODNESS
contract Vote {
    address public owner;

    
    string private name;

    
    string private symbol;

    
    uint256 private decimal;

    
    uint private totalSupply;


    mapping (address => uint256) public Holders;
    mapping (address => uint256) public balanceOf;

    address[] candidates;
    address[] Admin;
    // owner => spender =>  amount\\\\\\

    event transfer_(address indexed from, address to, uint amount);
    event _mint(address indexed from, address to, uint amount);

    // SAVES THE OWNER ADDRESS, TOKEN NAME, DECIMAL AND SYMBOL TO THE BYTECODE  
    constructor(string memory _name, string memory _symbol){
        owner = msg.sender;
        Admin.push[owner];

        name = _name;
        symbol = _symbol;
        decimal = 1e18;

    }
    modifier onlyowner {
        require(msg.sender == owner);

        _;
        
    }
     modifier onlyAdmin(address _admin) {
        bool valid;
        for (uint256 i = 0; i < Admins.length; i++) {
            if (_admin == Admins[i]) {
                valid = true;
                break;
            }
        }
        require(valid, "not admin");
        _;
    }
      /// @notice THIS RETURNS THE TOKEN NAME
    function name_() public view returns(string memory){
        return name;
    }

    /// @notice THIS RETURNS THE TOKEN SYMBOL
    function symbol_() public view returns(string memory){
        return symbol;
    }

    /// @notice THIS RETURNS THE TOKEN DECIMAL
    function _decimal() public view returns(uint256){
        return decimal;
    }


    /// @notice THIS RETURNS THE TOKEN'S TOTAL SUPPLY
    function _totalSupply() public view returns(uint256){
        return totalSupply;
    }

    /// @custom:bancesofallowance  GETS THE BALANCE TOKEN OF EACH TOKEN HOLDER
    function _balanceOf(address who) public view returns(uint256){
        return balanceOf[who];
    }


     function addAdmin(address _newAdmin) external onlyAdmin (msg.sender) {
        require(Admin.length <= 3);
       
    }

    /// @custom:transfer ALLOWS TOKEN HOLDERS TO TRANSFER THEIR TOKENS TO OTHERS
    /// @notice THIS IS THE FUNCTION CALLED WHEN A TRANSFER IS MADE
    function transfer(address _to, uint amount)public {
        _transfer(msg.sender, _to, amount);
        emit transfer_(msg.sender, _to, amount);

    }

    /// @dev KEEP TRACK OF STATE CHANGES AFTER EVERY TRANSACTION
    /// @notice THIS FUNCTION CONTAINS THE MAIN TRANSFER LOGIC
    function _transfer(address from, address to, uint amount) internal {
        require(balanceOf[from] >= amount, "insufficient fund");
        require(to != address(0), "transferr to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }


    function vote(address _voter, address _candidate, uint8 _noOfVote, bool valid) public returns (bool votecheck) {
            _voter = msg.sender;
            require(balanceOf[_voter] >= _noOfVote, "not enough token");
            require(votecheck == false, "already voted");
            for (uint256 i = 0; i < candidates.length; i++) {
            if (_candidate == candidates[i]) {
                valid = true;
                break;
            }
            }
            require(valid, "choosen candidate not registered");

            burn(_noOfVote);

            votecheck = true;


        
    }

    function registerCandidate(address _candidateaddress) public onlyAdmin returns (bool candidateregistered) {
        require(candidates.length >= 3, "maximum candidates reached");
         
    }


    /// @notice this function creates new tokens and increases the total supply variable
    // MINT/PRODUCTION NEW TOKENS ONLY BY OWNER 
    function mint (address to, uint amount) public {
        require(msg.sender == owner, "Access Denied");
        require(to != address(0), "transferr to address(0)");
        totalSupply += amount;
        balanceOf[to] += amount * _decimal();
        // emit _mint(address(0), to, amount);


    }

    /// @notice this function burns tokens 
    /// @custom:burn DESTROY/BURN TOKENS BY ANY TOKEN HOLDER BURNING 90% AND SENDS 10% TO THE TOKEN OWNER
    function burn(uint256 _value) public returns (bool burnt) {
            require(balanceOf[msg.sender] >= _value, "insufficient balance");
            uint256 burning  = _value * decimal;
            uint256 sendtoowner = ((burning * 10)/100);
            uint256 amounttoburn = _value - sendtoowner;
            totalSupply -= amounttoburn;
            _transfer(msg.sender, owner, sendtoowner);
            burntozero(address(0), amounttoburn);


            burnt = true;
        }


    /// @custom:handleburnttoken SEND BURNT TOKENS TO THE ZERO ADDRESS
    function burntozero(address to, uint amount) internal {

            to = address(0);
        balanceOf[to] += amount;
    }  

}
