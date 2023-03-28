
# Ethereum-Sign-Transactions
  

### Usercase

  

This is small application with ERC712 NFT to test what happed if we mint single NFT and Redeem Multiple NFT in one function call how it is going to effect the cost of transaction does if effect any significant price change doing this 
 
 More details of Result are upload of Article on Medium.
 [![Touqeer Medium](https://img.shields.io/badge/Medium-000000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@touqeershah32/ethereum-sign-transactions-60b1cc5dea4a)
  
# Getting Started
 

## Requirements  

- [Nodejs](https://nodejs.org/en/)

- You'll know you've installed nodejs right if you can run:

-  `node --version` and get an ouput like: `vx.x.x`

- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) instead of `npm`

- You'll know you've installed yarn right if you can run:

-  `yarn --version` and get an output like: `x.x.x`

- You might need to install it with npm


  

## Quickstart

  

```

git clone https://github.com/touqeerShah/Ethereum-Sign-Transactions.git

cd Ethereum-Sign-Transactions

npm i

```

  

# Usage

  

Start Node:

```

hh node

```

  Run Tests
  `unit-test-contract.test` increase number of call on one function or increase redeem function array size to see different test results.

  
  

# Deployment to a testnet or mainnet

  

1. Setup environment variabltes

  

You'll want to set your `GOERLI_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

  

-  `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.

- You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).

-  `GOERLI_RPC_URL`: This is url of the goerli testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981) or [Infura](https://www.infura.io/)

  

```

#### .evn

PRIVATE_KEY_0=<PRIVATE_KEY_0>

PRIVATE_KEY_1=<PRIVATE_KEY_1>

INFURA_API_KEY=<INFURA_API_KEY>

PROVIDER_REN_URL=<PROVIDER_REN_URL>

ETHERSCANAPIKEY=<ETHERSCANAPIKEY>

COINMARKETCAP_API_KEY=<COINMARKETCAP_API_KEY>

IPFS_SIMPLE=<IPFS_SIMPLE>

MUMBAI_RPC_URI=<MUMBAI_RPC_URI>

```

  

2. Get testnet ETH

  

Head over to [Alchemy](https://goerlifaucet.com/) and get some tesnet ETH. You should see the ETH show up in your metamask.

  

3. Deploy

  

```

yarn hardhat deploy --network goerli

```

  

## Staging Testing

  

After deploy to a testnet or local net, you can run staging test.

  

```

yarn run test:staging

```

  

## Estimate gas

  

You can estimate how much gas things cost by running:

  

```

yarn hardhat test

```

  

And you'll see and output file called `gas-report.txt`

  

### Estimate gas cost in USD

  

To get a USD estimation of gas cost, you'll need a `COINMARKETCAP_API_KEY` environment variable. You can get one for free from [CoinMarketCap](https://pro.coinmarketcap.com/signup).

  

Then, uncomment the line `coinmarketcap: COINMARKETCAP_API_KEY,` in `hardhat.config.js` to get the USD estimation. Just note, everytime you run your tests it will use an API call, so it might make sense to have using coinmarketcap disabled until you need it. You can disable it by just commenting the line back out.

  

## Verify on etherscan

  

If you deploy to a testnet or mainnet, you can verify it if you get an [API Key](https://etherscan.io/myapikey) from Etherscan and set it as an environemnt variable named `ETHERSCAN_API_KEY`. You can pop it into your `.env` file as seen in the `.env.example`.

  

In it's current state, if you have your api key set, it will auto verify goerli contracts!

  

However, you can manual verify with:

  

```

yarn hardhat verify --constructor-args arguments.js DEPLOYED_CONTRACT_ADDRESS

```

  

Or when you Run you Deploy it will automatical verify the conteact when it was on testnet

  

Contract Address Testnet

```
hh  test --network localhost
```

  

# Thank you!

  

[![Touqeer Medium](https://img.shields.io/badge/Medium-000000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@touqeershah32)

[![Touqeer YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UC3oUDpfMOBefugPp4GADyUQ)

[![Touqeer Linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/touqeer-shah/)




