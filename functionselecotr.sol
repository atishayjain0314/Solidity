//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract FucntionSelector{
    function getselector(string calldata _func) external returns(bytes4){
        return bytes4(keccak256(bytes(_func)));
    }
    
}

contract foo{
    event Log(bytes data);
    function func(address ad,uint val) external {
        emit Log(msg.data);
    }
}