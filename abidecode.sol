//SPDX-License-Identifer: MIT

pragma solidity 0.8.19;

contract AbiDecode{
    struct MyStruct{
        string name;
        uint[2] nums;
    }
    function Encode
    (
        uint x,
        address addr,
        uint[] calldata arr,
        MyStruct calldata myStruct
    )
    external
    view
    returns(bytes memory)
    {
        return abi.encode(x,addr,arr,myStruct);
    }

    function Decode(bytes calldata data)
    external 
    view 
    returns(uint x,address addr,uint[] memory arr,MyStruct memory myStruct)
    {
        (x,addr,arr,myStruct) = abi.decode(data,(uint,address,uint[],MyStruct));
    }
    
}