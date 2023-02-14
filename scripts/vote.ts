import { isAddress } from "ethers/lib/utils";
import { ethers } from "hardhat";

async function main() {
  const [owner, admin1, admin2, admin3] = await ethers.getSigners();
  const contestants = [admin1, admin2, admin2]
  console.log(owner.address, admin1.address, admin2.address, admin3.address);



  const Vote = await ethers.getContractFactory("Vote");
  const vote = await Vote.deploy("SUPERMAN","SG");
  await vote.deployed();

  console.log(`Multisig Address is ${vote.address}`);

  const newadmin = await vote.addAdmin(admin1.address);

  await vote.transfer(admin2.address, 100);



  const candidates = await vote["registerCandidate(address)"];
  console.log(candidates);

  await vote.vote(admin3.address, 3);

  await vote.vote(admin1.address, 5);

  await vote.vote(admin2.address, 7);








}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
