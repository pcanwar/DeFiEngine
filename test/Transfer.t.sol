// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";
import "../src/StakingRewards.sol";
import "forge-std/console.sol";
// import "@openzeppelin/contracts/token/ERC20/utils/SafeMath.sol";

import {MockERC20} from "./mocks/MockERC20.sol";
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract BaseTest is Test {

    // using SafeMath for uint256;
    StakingRewards public stakingRewards;
    uint256 maxAmountToMint = 20e18;
    MockERC20 public testToken;

    address internal userA;
    address internal userB;
    address internal userC;

    function setUp() public virtual {
        userA = address(uint160(uint256(keccak256(abi.encodePacked("userA")))));
        userB = address(uint160(uint256(keccak256(abi.encodePacked("userB")))));
        userC = address(uint160(uint256(keccak256(abi.encodePacked("userC")))));
        
        vm.label(userA, "userA");
        vm.label(userB, "userB");
        vm.label(userC, "userC");

        vm.prank(userA);
        task = new StakingRewards();

        testToken = new MockERC20("A", "a");

        console.log("userA", userA);
        console.log("userB", userB);
        console.log("userC", userC);
        console.log(" owner  ", task.owner());
        console.log(" contract address  ", address(task));

    }
}

// contract Mock20Token is BaseTest {
//     function setUp() public virtual override {
//         BaseTaskTest.setUp();
//         console.log("Test mint and check the balnce");
//     }

//     function mint(
//         MockERC20 erc20ContractAddress,
//         address to,
//         uint256 amount
//     ) internal {
//         vm.prank(to);
//         erc20ContractAddress.mint(to, amount);
//     }

//     function approve(
//         MockERC20 erc20ContractAddress,
//         address caller,
//         address spender,
//         uint256 amount
//     ) internal {
//         vm.prank(caller);
//         erc20ContractAddress.approve(spender, amount);
//     }
// }

// contract UserMintandDepositToTask is Mock20Token {
//     function setUp() public override {
//         Mock20Token0.setUp();
//         console.log("Mock20Token is ready ");
//     }

//     function testSend() public {
//         // user A mint and approve tokens 
//         MockERC20 XERC20Token = MockERC20(address(_0_mockERC20));
//         mint(XERC20Token, userA, maxAmountToMint);
//         assertEq(XERC20Token.balanceOf(userA), maxAmountToMint);
//         console.log(userA, " minting  ", maxAmountToMint);

//         approve(XERC20Token, userA, address(task), approveAmount);

//         // stakeReward recived the token
//         bool res = task.stake(
//             address(XERC20Token),
//             userA,
//             maxAmountToMint
//         );
//         assertTrue(res);
//     }

// }