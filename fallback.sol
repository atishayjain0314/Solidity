//SPDX-License-Identifier: MIT



contract Fallback{
    event Log(string func,address sender,uint value,bytes data);
    fallback() external payable{
        emit Log("fallback",msg.sender,msg.value,msg.data);

    }
    function get() external view returns(uint){
        return address(this).balance;
    }
    
    
}