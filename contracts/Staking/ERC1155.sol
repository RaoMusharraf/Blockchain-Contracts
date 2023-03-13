// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC1155, Ownable {
    address AdminAddress;
    constructor() ERC1155("") {
        AdminAddress = msg.sender;
    }
    struct Minter{
        uint256 id;
        uint256 price;
        uint256 amount;
        bool listed;
    }
    mapping(address => uint256) public IdCounter;
    mapping(uint256 => uint256) public Counter;
    mapping(address => mapping(uint256 => uint256)) public OwnerIds;
    mapping(uint256 => uint256) public IdAmount;
    mapping(uint256 => uint256) public IdOwners;
    mapping(address => mapping(uint256 => Minter)) public MinterDetail;
    mapping(uint256 => mapping(uint256 => address)) public Owners;
    mapping(address => mapping(uint256 => bool)) public List;

    function mint(address account, uint256 id, uint256 amount,uint256 price) public payable {
        require((IdAmount[id] + amount) <= 4,"No More Owner");
        IdAmount[id] += amount;
        // OwnerIds[account][(IdCounter[account]+1)] = id;
        Owners[id][(Counter[id]+1)] = account;
        MinterDetail[account][id] = Minter(id,price,amount,false);
        _mint(account, id, amount, "");
        payable(AdminAddress).transfer(price);
        // IdCounter[account] += 1;  
        Counter[id] += 1;  
    }
    // function viewNFT(address account) public view returns(Minter[] memory){
    //     Minter[] memory UserDetail = new Minter[](IdCounter[account]);
    //     uint Index = 0;
    //     for (uint i = 1; i <= IdCounter[account]; i++) {
    //             UserDetail[Index] = MinterDetail[account][OwnerIds[account][i]];
    //             Index++;
    //         }
    //     return UserDetail;
    // }
    function ListProperty(address account,uint256 id,uint256 price) public {
        require(!MinterDetail[account][id].listed,"Already Listed");
        safeTransferFrom(account, address(this), id,MinterDetail[account][id].amount,"");
        List[account][id] = true;
        MinterDetail[account][id].listed = true;
        MinterDetail[account][id].price = price;
    }
    function BuyProperty(address account,uint256 id,uint256 amount) public payable {
        for( uint i=1; i <= Counter[id] ; i++){
            if(List[Owners[id][i]][id] == true && amount == MinterDetail[Owners[id][i]][id].amount){
                safeTransferFrom( address(this) ,account, id, amount, "");
                payable(Owners[id][i]).transfer(MinterDetail[Owners[id][i]][id].price );
                MinterDetail[account][id] = Minter(id,MinterDetail[Owners[id][i]][id].price ,amount,false);
                delete MinterDetail[Owners[id][i]][id] ;
                Owners[id][i] = account;
                break;
            }
        }    
    }
}