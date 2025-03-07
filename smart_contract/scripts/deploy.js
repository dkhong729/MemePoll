const hre = require("hardhat");

async function main() {
  const Vote = await hre.ethers.getContractFactory("AdvancedMemeVote");
  const vote = await Vote.deploy(3, true, 80);
  await vote.deployed();
  console.log("AdvancedMemeVote deployed to:", vote.address);
}

main().catch(console.error);