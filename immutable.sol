//SPDX-License-Identifier: MIT



contract Immutable{
    address public immutable owner;
    constructor(){
        owner = msg.sender;
    }
    uint public x;
    function foo() external{
        require(msg.sender==owner);
        x++;
    }
}
