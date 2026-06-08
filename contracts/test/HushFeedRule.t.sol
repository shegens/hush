// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/HushFeedRule.sol";

contract HushFeedRuleTest is Test {
    HushFeedRule rule;
    address alice = address(0xA11CE);
    address bob   = address(0xB0B);

    function setUp() public {
        rule = new HushFeedRule();
    }

    function test_firstPostAllowed() public {
        rule.processCreatePost(1, alice, "");
        assertEq(rule.lastPostAt(alice), block.timestamp);
    }

    function test_secondPostWithin24hReverts() public {
        rule.processCreatePost(1, alice, "");
        vm.expectRevert(abi.encodeWithSelector(
            HushFeedRule.TooSoon.selector,
            block.timestamp + 86400
        ));
        rule.processCreatePost(2, alice, "");
    }

    function test_secondPostAfter24hAllowed() public {
        rule.processCreatePost(1, alice, "");
        vm.warp(block.timestamp + 86400);
        rule.processCreatePost(2, alice, "");
    }

    function test_differentUsersIndependent() public {
        rule.processCreatePost(1, alice, "");
        rule.processCreatePost(2, bob, ""); // bob unaffected
    }

    function test_cooldownRemaining() public {
        rule.processCreatePost(1, alice, "");
        vm.warp(block.timestamp + 3600); // 1h later
        assertEq(rule.cooldownRemaining(alice), 82800); // 23h left
    }

    function test_cooldownZeroBeforeFirstPost() public {
        assertEq(rule.cooldownRemaining(alice), 0);
    }
}
