# NFTance
Mint, buy, sell, and explore unique digital NFTs on our platform, providing secure and transparent ownership of digital video content with the power of Cardano zkEVM Testnet.
## Tech Stack
### Frontend
- React.js
- Material UI
- CSS
- Ethersjs
### Backend
- Solidity
- IPFS (Pinata)
- openzeppelin
- cardona zkEVM Testnet


## Features of THETAVID:

- Creation and Ownership: Users can easily create, manage, and monetize their own NFTs, ensuring true ownership.
- Trading: Users can list their digital NFTs for sale, purchase, or trade.
- Content Security: To protect intellectual property, the platform implements watermarks on NFT images and restricts video previews to a few seconds, reducing the risk of unauthorized screenshots and content theft.
- Ownership Transfer: Automatic transfer of ownership upon transaction completion.

## Smart Contracts:
- contract.sol: Smart contract for minting and managing digital NFTs and handling marketplace functionalities like sale, purchase, or trade.
- OpenZeppelin: Implementation of the ERC721 standard for non-fungible tokens (NFTs).

## Run Locally

Clone the project

```bash
  git clone https://github.com/Aditya-Chaurasia11/THETAVID.git
```

Go to the project directory

```bash
  cd THETAVID
```

Install dependencies

```bash
  npm install
```

Start the Game

```bash
  npm run dev
```

## Project flow

  Check this for video demo [Click here](https://youtu.be/g1x9t9aYz7w?si=orSo_TAYX3gDNyL4)

- Video NFT Creation
    - Upload Video & Metadata: Users upload their video to IPFS and provide metadata like title and description.
    - Mint NFT: The createNFT function in VideoNFT.sol mints the video and metadata as an NFT on the blockchain.

![Gameplay](https://i.postimg.cc/ZK75BSJK/img1.jpg)


- Listing NFT for Sale
    - Set Sale Price: Users set the price for their NFT.
    - List on Marketplace: The Mapitem function in Marketplace.sol lists the NFT and marks it for sale.

![Gameplay](https://i.postimg.cc/Gh5b3xj4/img2.jpg)


- Marketplace Browsing
    - Browse NFTs: Users explore available NFTs using filter options.
    - Preview Video: Users watch a short preview of the video before purchasing.

 ![Gameplay](https://i.postimg.cc/Wb32PH0R/img3.jpg)



- Purchasing NFT
    - Select NFT: Choose the NFT to buy.
    - Complete Purchase: Process the transaction to transfer ownership.
 
![Gameplay](https://i.postimg.cc/Xq24CfSD/img4.jpg)


  
