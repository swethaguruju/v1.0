// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicDutchAuction {
    address payable public owner;
    uint256 public reservePrice;
    uint256 public numBlocksAuctionOpen;
    uint256 public offerPriceDecrement;
    uint256 public initialPrice;
    uint256 public startBlock;
    bool public auctionEnded;

    constructor(
        uint256 _reservePrice, 
        uint256 _numBlocksAuctionOpen, 
        uint256 _offerPriceDecrement
    ) {
        owner = payable(msg.sender);
        reservePrice = _reservePrice;
        numBlocksAuctionOpen = _numBlocksAuctionOpen;
        offerPriceDecrement = _offerPriceDecrement;
        initialPrice = reservePrice + numBlocksAuctionOpen * offerPriceDecrement;
        startBlock = block.number;
        auctionEnded = false;
    }

    function bid() public payable {
        require(!auctionEnded, "Auction has ended");
        require(block.number <= startBlock + numBlocksAuctionOpen, "Auction duration has passed");
        uint256 currentPrice = getCurrentPrice();
        require(msg.value >= currentPrice, "Bid must be at least the current price");

        // Transfer the amount to owner
        owner.transfer(msg.value);
        // End the auction
        auctionEnded = true;
    }

    function getCurrentPrice() public view returns (uint256) {
    if (block.number > startBlock + numBlocksAuctionOpen) {
        return reservePrice;
    }
    return initialPrice - offerPriceDecrement * (block.number - startBlock);
}

    }

