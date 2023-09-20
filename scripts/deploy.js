async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const tournamentBracketGenerator = await ethers.deployContract("TournamentBracketGenerator");

  console.log("tournamentBracketGenerator address:", await tournamentBracketGenerator.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });