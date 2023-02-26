//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract visibility{
    uint private x = 0;
    uint internal y=1;
    uint public z=2;

    function privatefun() private pure returns(uint){
        return 0;
    }
    function internalFunc() internal pure returns(uint){
        return 100;
    }
    function publicfunc() public pure returns(uint){
        return 200;
    }
    function externalfunc() external pure returns(uint){
        return 300;
    }
    function examples() external{
        x++;
        y++;
        z++;
        privatefun();
        internalFunc();
        publicfunc();  
        this.externalfunc();

    }
}

contract child is visibility{
    function examples2() external{
        y++;
        z++;
        internalFunc();
        publicfunc();
        
    }
}