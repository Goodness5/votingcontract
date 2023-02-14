import { ethers } from "hardhat";

async function main() {
  const [owner, admin1, admin2, admin3] = await ethers.getSigners();
  const contestants = [admin1, admin2, admin2]
  console.log(owner.address, admin1.address, admin2.address, admin3.address);



  const Vote = await ethers.getContractFactory("Vote");
  const vote = await Vote.deploy("SUPERMAN","SG");
  await vote.deployed();

  console.log(`Multisig Address is ${vote.address}`);

  const addAmin = await vote.addAdmin(admin1.address);
  







}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
