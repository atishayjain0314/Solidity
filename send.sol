//SPDX-License-Identifier: MIT



contract SendEther{
    
    constructor() payable{}

    fallback() external payable{
       
    }
    receive() external payable{
        
    }
    function sendViaTranfer(address payable _to) external payable{
        _to.transfer(123);
    }
    function sendViasend(address payable _to) external payable{
       bool sent =  _to.send(123);
       require(sent,"send falied");
    }
    function sendViacall(address payable _to) external payable{
        (bool success,bytes memory data) = _to.call{value: 123}("");
        require(success,"call failed"); 
    }

}

contract EthReceiver{
    event Log(uint amount,uint gas);
    receive() external payable{
        emit Log(msg.value,gasleft());
    }
}