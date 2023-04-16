// SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

contract AccessControl {
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    mapping (bytes32 => mapping(address => bool)) public roles;

    bytes32 private constant ADMIN = keccak256(abi.encodePacked('ADMIN'));
    bytes32 private constant USER = keccak256(abi.encodePacked('USER'));

    modifier onlyRole(bytes32 _role){
        require(roles[_role][msg.sender], 'not quthhorized');
        _;
    }
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes _role, address _account) internal{
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes _role, address _account) external onlyRole(ADMIN){
        _grantRole(_role, _account);
    }

    function revokeRole(bytes _role, address _account) external onlyRole(ADMIN){
         roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

}