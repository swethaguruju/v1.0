const { ethers } = require('hardhat');
const { expect } = require('chai');

describe('BasicDutchAuction', function () {
  let Auction, auction, owner, addr1, addr2;

  beforeEach(async function () {
    Auction = await ethers.getContractFactory('BasicDutchAuction');
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    auction = await Auction.deploy(ethers.utils.parseEther('1'), 10, ethers.utils.parseEther('0.1'));
    await auction.deployed();
  });

  it('Should initialize with correct values', async function () {
    expect(await auction.reservePrice()).to.equal(ethers.utils.parseEther('1'));
    expect(await auction.numBlocksAuctionOpen()).to.equal(10);
    expect(await auction.offerPriceDecrement()).to.equal(ethers.utils.parseEther('0.1'));
    expect(await auction.owner()).to.equal(owner.address);
    expect(await auction.auctionEnded()).to.equal(false);
  });

it('Should end auction when bid is high enough', async function () {
    // Increase time to 5 blocks later
    // Increase time to 5 blocks later
// Increase time to 5 blocks later
for(let i = 0; i < 5; i++) {
    await ethers.provider.send("evm_mine");
}

// Get the current price from the contract
let currentPrice = await auction.getCurrentPrice();

// Place a bid with value greater than or equal to the current price
await auction.connect(addr1).bid({ value: currentPrice });
expect(await auction.auctionEnded()).to.equal(true);

});



  // Add more tests as needed
});
