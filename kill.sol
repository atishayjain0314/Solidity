//SPDX-License-Identifier: MIT



contract y{
    constructor() payable{}

    function kill() external{
        selfdestruct(payable(msg.sender));
    }
    function testcall() external pure returns(uint){
        return 123;
    }
}

contract Helper{
    function getbalance() external view returns(uint){
        return address(this).balance;
    }
    function x(y _test) external{
        _test.kill();
    }
}