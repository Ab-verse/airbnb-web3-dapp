# Tournament Bracket Generator

This is a Solidity smart contract named `TournamentBracketGenerator` designed to manage a tournament bracket with multiple rounds and matches. It provides the functionality to create brackets based on the number of participants and update match results in the bracket.

## Features

- Create a tournament bracket with a specified number of participants.
- Update match results in the bracket.
- Check if a number is a power of two (used for participant validation).
- Retrieve the current state of the tournament bracket.

## Prerequisites

Before deploying this contract, you need to:

1. [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
    - You'll know you did it right if you can run ```git --version``` and you see a response like ```git version x.x.x```
  
2. [NodeJS](https://nodejs.org/en/)
    - You'll know you've installed nodejs right if you can run:
    - ```node --version``` and get an ouput like: ```vx.x.x```

3. [Npm] (https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
    - You'll know you've installed npm right if you can run:
        - npm ```--version``` and get an output like: ```x.x.x```

## Usage

1. ``npm install``
2. Set env variables as per ``.env.example``

3. Compile the Lottery contract ``npx hardhat compile``
4. Deploy the contract to the Ethereum network. 
   ``npx hardhat run scripts/deploy.js --network sepolia``
5. Verify the contract on Etherscan
    ``npx hardhat verify --network sepolia <CONTRACT_ADDRESS> "Constructor Arguments"``

Thats It..

## Thank you!

[![Abhishek S Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/Abverse_)
[![Abhishek S](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abhishek-s-ckm)