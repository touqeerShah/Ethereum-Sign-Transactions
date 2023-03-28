import { expect } from "chai";
import { Signer } from "ethers";
import { ethers } from "hardhat";
import { UserIdentityNFT } from "../typechain-types";
import { UserIdVoucherStruct } from "../typechain-types/contracts/core/UserIdentityNFT";


import { getUserIdentityNFT } from "../instructions"
import { getStringToBytes } from "../utils/convert"
import { createUserId } from "../instructions"
import { SIGNING_DOMAIN_NAME, SIGNING_DOMAIN_VERSION, IPFS_SIMPLE } from "../helper-hardhat-config"

describe("FigurePrintOracle", async function () {
  let deployer: Signer;
  let deployer2: Signer

  let userIdentityNFT: UserIdentityNFT;
  let voucher: UserIdVoucherStruct;
  let voucher2: UserIdVoucherStruct;

  before(async () => {
    [deployer, deployer2] = await ethers.getSigners(); // could also do with getNamedAccounts

    const _userId = getStringToBytes("touqeershah32@gmail.com")
    const _name = getStringToBytes("Touqeer Shah")
    userIdentityNFT = await getUserIdentityNFT();
    voucher = (await createUserId(
      userIdentityNFT,
      deployer,
      _userId,
      IPFS_SIMPLE,
      _name,
      SIGNING_DOMAIN_NAME,
      SIGNING_DOMAIN_VERSION,
    )) as UserIdVoucherStruct;
    voucher2 = (await createUserId(
      userIdentityNFT,
      deployer2,
      _userId,
      IPFS_SIMPLE,
      _name,
      SIGNING_DOMAIN_NAME,
      SIGNING_DOMAIN_VERSION,
    )) as UserIdVoucherStruct;


  });

  describe("figurePrint Oracle Test", async function () {

    it("Create Single 10 NFT", async function () {
      for (let index = 0; index < 19; index++) {
        await expect(userIdentityNFT.connect(deployer).createSingleNFT(voucher)).to.emit(
          userIdentityNFT,
          "MintNft",
        );
      }

    });

    it("Create Multiple NFT in one Go", async function () {
      let vouchers: UserIdVoucherStruct[] = [voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2]
      vouchers.push(...vouchers) //20
      // vouchers.push(...vouchers)//160
      // vouchers.push(...[voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2])//320
      // vouchers.push(...[voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2, voucher, voucher2])//320

      // vouchers.push(...vouchers) //640
      // vouchers.push(...vouchers) //1280

      console.log("vouchers ", vouchers.length);

      await userIdentityNFT.connect(deployer2).redeem(vouchers)
    });
  });

});
