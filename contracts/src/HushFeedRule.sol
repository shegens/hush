// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title HushFeedRule
/// @notice Enforces one post per 24 hours per author on a Lens feed.
///         "24 hours" = 86400 seconds since last post, not calendar day.

interface IFeedRule {
    function processCreatePost(
        uint256 postId,
        address author,
        bytes calldata data
    ) external;
}

contract HushFeedRule is IFeedRule {
    /// @dev author => timestamp of last post
    mapping(address => uint256) public lastPostAt;

    uint256 public constant COOLDOWN = 86400; // 24 hours in seconds

    error TooSoon(uint256 nextAllowedAt);

    function processCreatePost(
        uint256, /* postId */
        address author,
        bytes calldata /* data */
    ) external override {
        uint256 last = lastPostAt[author];
        if (last != 0 && block.timestamp < last + COOLDOWN) {
            revert TooSoon(last + COOLDOWN);
        }
        lastPostAt[author] = block.timestamp;
    }

    /// @notice Seconds until `author` can post again. 0 = can post now.
    function cooldownRemaining(address author) external view returns (uint256) {
        uint256 last = lastPostAt[author];
        if (last == 0) return 0;
        uint256 next = last + COOLDOWN;
        if (block.timestamp >= next) return 0;
        return next - block.timestamp;
    }
}
