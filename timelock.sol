//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract TimeLock{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    uint public constant MIN_DELAY = 100;
    uint public constant MAX_DELAY = 1000;
    uint public constant GRACE_PERIOD = 1000;

    modifier onlyowner{
        require(msg.sender==owner,"not the owner");
        _;
    }
    event Queued(bytes32 txId,address _target,uint _value,bytes  _data,string  _func,uint _timestamp);
    event Executed(bytes32 txId,address _target,uint _value,bytes  _data,string  _func,uint _timestamp);
    event Cancel(bytes32 txId);
    mapping(bytes32=>bool) queued;
    function gettxId(
        address _target,
        uint _value,
        bytes calldata _data,
        string calldata _func,
        uint _timestamp
    ) public pure returns(bytes32)
    {
        return keccak256(abi.encode(_target,_value,_data,_func,_timestamp));
    }
    function queue(
        address _target,
        uint _value,
        bytes calldata _data,
        string calldata _func,
        uint _timestamp
    ) external onlyowner
    {
        bytes32 txId = gettxId(_target,_value,_data,_func,_timestamp);
        require(queued[txId]==false,"already queued");
        require(
            _timestamp>block.timestamp + MIN_DELAY ||
            _timestamp<block.timestamp + MAX_DELAY ,
            "TimeStampNotInRange"
        );
        queued[txId]=true;
        emit Queued(txId,_target,_value,_data,_func,_timestamp);
    }

    function execute(
        address _target,
        uint _value,
        bytes calldata _data,
        string calldata _func,
        uint _timestamp
    ) external onlyowner returns(bytes memory)
    {
        bytes32 txId = gettxId(_target, _value, _data, _func, _timestamp);
        require(queued[txId]==true,"Not queued");
        require(block.timestamp>_timestamp,"NotPassedthetimestamp");
        require(block.timestamp<_timestamp+GRACE_PERIOD,"Expired");
        queued[txId]=false;
        bytes memory data;
        if(bytes(_func).length>0){
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))),_data);
        }
        else{
            data = _data;
        }
        (bool success,bytes memory  res)=_target.call{value:_value}(data);
        require(success,"Transaction failed");
        emit Executed(txId,_target,_value,_data,_func,_timestamp);
        return res;
    }

    function _Cancel(bytes32 txId) external onlyowner
    {
        require(queued[txId]==true,"not queued");
        queued[txId]=false;
        emit Cancel(txId);
    }

}

contract testTimeLock{
    address public timelock;
    constructor(address _timelock){
        timelock = _timelock;
    }

    function test() external{
        require(msg.sender==timelock,"Not");
    }
    function getTimeStamp() external view returns(uint){
        return block.timestamp + 100;
    }
}