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
    StakingRewards public task;
    uint256 maxAmountToMint = 20e18;
    MockERC20 public mockERC20;

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

        mockERC20 = new MockERC20();

        console.log("userA", userA);
        console.log("userB", userB);
        console.log("userC", userC);
        // console.log(" owner  ", task.owner());
        console.log(" contract address  ", address(task));

    }
}

contract Mock20Token is BaseTest {
    function setUp() public virtual override {
        BaseTest.setUp();
        console.log("Test mint and check the balnce");
    }

    function mint(
        MockERC20 mockERC20,
        address to,
        uint256 amount
    ) public {
        vm.prank(to);
        mockERC20.mint(to, amount);
    }

    function approve(
        MockERC20 mockERC20,
        address caller,
        address spender,
        uint256 amount
    ) internal {
        vm.prank(caller);
        mockERC20.approve(spender, amount);
    }
}

contract UserMintandDepositToTask is Mock20Token {
    function setUp() public override {
        Mock20Token.setUp();
        console.log("Mock20Token is ready ");
    }

    function testSend() public {
        // user A mint and approve tokens 
        MockERC20 XERC20Token = MockERC20(address(mockERC20));
        task.init(address(XERC20Token), address(XERC20Token));

        mint(XERC20Token, userA, maxAmountToMint);
        assertEq(XERC20Token.balanceOf(userA), maxAmountToMint, "User Bla eq");
        console.log(userA, " minting  ", maxAmountToMint);

        // uint256 approveAmount = maxAmountToMint ;
        // vm.prank(userA);
        approve(XERC20Token, userA, address(task), maxAmountToMint);

        // // stakeReward recived the token
        vm.prank(userA);
        task.Stake(userA, maxAmountToMint);
        console.log("balanceXERC20Token :");
        // console.log(address(XERC20Token));
        assertEq(mockERC20.balanceOf(address(task)), maxAmountToMint);
        // assert
        // 0xE5B20Fb06A9dB27b835626a92Cb09d47Aea4aF59
        // assertTrue(res);
        uint256 balUserA = task.balanceOf(address(userA));
        console.log("balance userA :", balUserA);

        vm.prank(userA);
        task.UnStake(address(userA), balUserA );
        // assertEq(mockERC20.balanceOf(address(task)), 0);

    }

}