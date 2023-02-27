//SPDX-License_identifier: MIT

pragma solidity 0.8.17;


// contract Counter{
//     uint public count;

//     function inc() external{
//         count+=1;
//     }
//     function dec() external{
//         count-=1;
//     }

// }

interface ICounter{
    function cnt() external view returns (uint);
    function inc() external;
}

contract CallInterface{
    uint public cnti;
    function examples(address _counter) external{
        ICounter(_counter).inc();
        cnti = ICounter(_counter).cnt();
    }
}