//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IERC20{
    function TotalSupply()external view returns(uint256);

    function Transfer(address _to,uint256 amount) external returns(bool);

    function balanceOf(address _owner) external view returns(uint256);

    function TransferFrom(address _owner,address _to,uint256 amount) external returns(bool);

    function approval(address spender,uint amount) external returns(bool);

    function allowance(address _owner,address spender) external returns(uint256);

    event Transfer_(address from,address to,uint256 value);
    event Approval_(address owner,address spender,uint256 value);
}

contract ERC20{
    event Transfer_(address from,address to,uint256 value);
    event Approval_(address owner,address spender,uint256 value);
    uint256 publicsupply;
    mapping(address=>uint256) balanceOf;
    mapping(address=>mapping(address=>uint256)) allowance;
    string public name = "Atishay";
    string public symbol = "AJ";
    uint8 public decimals = 18;

    function Transfer(address _to,uint256 amount) external returns(bool){
        balanceOf[msg.sender]-=amount;
        balanceOf[_to]+=amount;
        emit Transfer_(msg.sender,_to,amount);
        return true;
    }

    function approval(address spender,uint256 amount) external returns(bool){
        allowance[msg.sender][spender]=amount;
        emit Approval_(msg.sender,spender,amount);
        return true;
    }

    function TransferFrom(address owner,address _to,uint256 amount) external returns(bool){
        allowance[owner][msg.sender]-=amount;
        balanceOf[owner]-=amount;
        balanceOf[_to]+=amount;
        emit Transfer_(owner,_to,amount);
    }

    function mint(uint256 amount) external{
        publicsupply+=amount;
        balanceOf[msg.sender]+=amount;
        emit Transfer_(address(0),msg.sender,amount);
    }
    function burn(uint256 amount) external{
        publicsupply-=amount;
        balanceOf[msg.sender]-=amount;
        emit Transfer_(msg.sender,address(0),amount);
    }

}