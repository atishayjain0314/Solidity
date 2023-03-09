//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IERC721{
    function transferfrom(address from,address to,uint nftId) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed bidder,uint amount);
    event Withdraw(address indexed bidder,uint amount);
    event End_(address highestbidder,uint amount);
    address payable  public immutable seller;
    IERC721 public immutable nft;
    uint public immutable nftId;
    bool public end;
    bool public started;
    uint32 public endAt;
    uint public highestbid;
    address public highestbidder;
    mapping(address=>uint) bids;
    constructor(address _nft,uint _nftId,uint starting_bid){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestbid = starting_bid;

    }

    function start() external{
        require(msg.sender==seller,"not the seller");
        require(started==false,"already started");
        started=true;
        endAt = uint32(block.timestamp + 60);
        nft.transferfrom(seller,address(this),nftId);
        emit Start();
    }

    function bid() external payable {
        require(started==true,"not started");
        require(block.timestamp<endAt,"ended");
        require(msg.value>highestbid,"lower bid");
        if(highestbidder!=address(0)){
            bids[highestbidder] += highestbid;
        }
        highestbid = msg.value;
        highestbidder = msg.sender;
        emit Bid(highestbidder,highestbid);
    }

    function withdraw() external payable {
        uint bal = bids[msg.sender];
        bids[msg.sender]=0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender,bal);
    }

    function End() external {
        require(block.timestamp>=endAt,"auction going on");
        require(started==true,"auction not started");
        require(end==false,"auction ended");
        end=true;
        if(highestbidder!=address(0)){
            nft.transferfrom(address(this),highestbidder,nftId);
            seller.transfer(highestbid);
        }else{
            nft.transferfrom(address(this),seller, nftId);
        }
        emit End_(highestbidder,highestbid);
    }
}