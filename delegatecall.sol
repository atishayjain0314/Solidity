//SPDX-Licnese-Identifier: MIT



contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable{
        num = 2*_num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test,uint _num) external payable{
        // (bool success,bytes memory data)=_test.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num));

        (bool success,bytes memory data)=_test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector,_num));
        require(success,"delegatecall failed");
    }

}