pragma solidity ^0.5.10;
import "./Roles.sol";
import "./Renounceable.sol";


/**
 * @title Community
 * @author Alberto Cuesta Canada
 * @notice Implements a single role Roles
 */
contract Community is Roles, Renounceable {

    bytes32 public constant COMMUNITY_ROLE_ID = "COMMUNITY";

    /// @dev Create the community role, with `root` as a member.
    constructor (address root) public {
        _addRole(COMMUNITY_ROLE_ID);
        _addMember(root, COMMUNITY_ROLE_ID);
    }

    /// @dev Restricted to members of the community.
    modifier onlyMember() {
        require(isMember(msg.sender), "Restricted to members.");
        _;
    }

    /// @dev Return `true` if the `account` belongs to the community.
    function isMember(address account) public view returns (bool) {
        return hasRole(account, COMMUNITY_ROLE_ID);
    }

    /// @dev Add a member of the community. Caller must already belong to the community.
    function addMember(address account) public onlyMember {
        _addMember(account, COMMUNITY_ROLE_ID);
    }

    /// @dev Remove oneself as a member of the community.
    function leaveCommunity() public { // Roles will check membership.
        renounceMembership(COMMUNITY_ROLE_ID);
    }
}