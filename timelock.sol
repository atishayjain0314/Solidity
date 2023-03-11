//SPDX-License-Identifer: MIT

pragma solidity 0.8.18;

contract GasGolf{
    //initial 50518
    uint public total;
    function sumIfEvenAndLessThan99(uint[] calldata nums) external{
        uint _total = total;
        for(uint i=0;i<nums.length;i++){
            if(nums[i] % 2 == 0 && nums[i]<99){
                _total+=nums[i];
            }
        }
        total = _total;
    }
}