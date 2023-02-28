//SPDX-License-Identifier: MIT



contract HashFunc{
    function hash(string memory text,uint num,address addr) external pure returns(bytes32){
        return keccak256(abi.encodePacked(text,num,addr));

    }
    function encode(string memory text1,string memory text2) external pure returns(bytes memory){
        return abi.encode(text1,text2);
    }
    function encodepact(string memory text1,string memory text2) external pure returns(bytes memory){
        return abi.encodePacked(text1,text2);
    }
    function collision(string memory text1,string memory text2) external pure returns(bytes32){
        return keccak256(abi.encode(text1,text2));
    }
}


