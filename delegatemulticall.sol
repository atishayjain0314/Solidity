//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract MultiDelegateCall{
    error ErrorMultiDelegateCall();
    function multidelegatecall(bytes[] memory data)
    external 
    returns(bytes[] memory)
    {
        bytes[] memory results = new bytes[](data.length);
        for(uint i;i<data.length;i++){
            (bool success,bytes memory result)=address(this).delegatecall(data[i]);
            if(success==false){
                revert ErrorMultiDelegateCall();
            }
            results[i] = result;
        }
        return results;
    }
}


contract TestMultiDelegateCall{
    event Log(address sender,string func,uint i);
    function func1(uint x,uint y) external {
        emit Log(msg.sender,"func1",x+y);
    }

    function func2() external returns(uint){
        emit Log(msg.sender,"func2",2);
        return 111;
    }

    function mint() external payable{
        // balanceOf[msg.sender]+=msg.value;
    }
}

contract helper{
    function getDatafunc1() external returns(bytes memory){
        return abi.encodeWithSelector(TestMultiDelegateCall.func1.selector);

    }

    function getDatafunc2() external returns(bytes memory){
        return abi.encodeWithSelector(TestMultiDelegateCall.func2.selector);
    }

    function getDatamint() external returns(bytes memory){
        return abi.encodeWithSelector(TestMultiDelegateCall.mint.selector);
    }
}