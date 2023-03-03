//SPDX-License-Identifier: MIT 

pragma solidity 0.8.19;

interface IERC721{
    function transform_from(address form,address to,uint _nftId) external;
}
contract DutchAuction{
    uint public DURATION = 7 days;
    uint public immutable starting_price;
    uint public immutable discount_rate;
    IERC721 public immutable nft;
    uint public immutable nftId;
    uint public immutable Start_at;
    uint public immutable End_at;
    address payable public immutable seller;
    constructor(
        uint _starting_price,
        uint _discount_rate,
        address _nft,
        uint _nftId
    ){
        starting_price = _starting_price;
        discount_rate = _discount_rate;
        seller = payable(msg.sender);
        require(_starting_price>=_discount_rate*DURATION,"starting price < discount");
        Start_at = block.timestamp;
        End_at = block.timestamp + DURATION;
        nft = IERC721(_nft);
        nftId = _nftId;
    }
    function getprice() public view returns(uint){
        uint timelapsed = block.timestamp - Start_at;
        uint dicount = discount_rate * timelapsed;
        return starting_price - dicount;
    }
    function buy() external payable{
        require(block.timestamp<=End_at,"end of time");
        require(msg.value>=getprice(),"ETH<value");
        nft.transform_from(seller,msg.sender,nftId);
        uint refund = msg.value-getprice();
        if(refund>0){
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }

}

