//SPDX-License-Identifier: MIT



contract CallTestContract{
    // function setX(address _test,uint _x) external{
    //     TestContract(_test).setX(_x);
    // }
    function setX(TestContract _test,uint _x) external{
        _test.setX(_x);
    }
    function getX(TestContract _test) external view returns(uint){
        return _test.getX();
    }
    function sendEther(TestContract _test,uint _x) external payable{
        _test.setXandRecieveEther{value:msg.value}(_x);
    }
    function getXandvalue(TestContract _test) external view returns(uint,uint){
        return _test.getXandvalue();
    }

}

contract TestContract{
    uint public x;
    uint public value = 123;
    function setX(uint _x) external{
        x = _x;
    }
    function getX() external view returns(uint){
        return x;
    }
    function setXandRecieveEther(uint _x) external payable{
        x = _x;
        value = msg.value;
    }
    function getXandvalue() external view returns(uint,uint){
        return (x,value);
    }
}