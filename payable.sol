//SPDX-License-Identifier: MIT



contract Payable{
    address payable public owner;
    constructor(){
        owner=payable(msg.sender);
    }
    function deposit() external payable{

    }
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}
