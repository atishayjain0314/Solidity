//SPDX-License-Identifier : MIT



contract TestCall{
    string public message;
    uint public x;
    
    event Log(string message);

    fallback() external payable{
        emit Log("fallback called");
    }
    function foo(string memory _message,uint _x) external payable returns (bool,uint){
        message = _message;
        x = _x;
        return (true,999);
    }
}

contract Call{
    bytes public data;
    function callFoo(address _test) external payable{
        (bool success,bytes memory _data) = _test.call{value:111,gas:200}(abi.encodeWithSignature("foo(string,uint256)","call foo",123));
        require(success,"call failed");
        data = _data; 
    }
    function callDoesNotExist(address _test) external{
        (bool success,)=_test.call(abi.encodeWithSignature("doesNotExist()"));
        require(success,"call failed");
    }
}