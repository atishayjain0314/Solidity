//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract TestMultiCall{
    function func1() external view returns(uint,uint){
        return (1,block.timestamp);
    }
    function func2() external view returns(uint,uint){
        return (2,block.timestamp);
    }

    function getData1() external pure returns(bytes memory){
        return abi.encodeWithSignature("func1()");
    }

    function getData2() external pure returns(bytes memory){
        return abi.encodeWithSignature("func2()");
    }

}

contract MultiCall{
    function multicall(address[] calldata targets,bytes[] calldata data)
    external
    view
    returns(bytes[] memory){
        require(targets.length==data.length,"lengths not same");
        bytes[] memory results = new bytes[](data.length);
        for(uint i;i<data.length;i++){
            (bool success,bytes memory result)=targets[i].staticcall(data[i]);
            require(success,"call failed");
            results[i]=result;
        }
        return results;
    }
}
