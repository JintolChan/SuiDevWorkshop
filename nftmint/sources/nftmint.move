// Jintol
module nftmint::nftmint {
    use std::string::{Self, String};
    use sui::url::{Self, Url};
    use sui::event;

    public struct JintolNFTEvent has copy, drop {
        object_id: ID,
        creator: address,
        name: String
    }


    // ###############################
    // struct 
    // ###############################
    public struct JintolNFT has key, store {
        id: UID,
        url: Url,
        name: String,
        description: String
    }

    public fun mint_nft(
        name: String, 
        url_str: String, 
        description: String, 
        ctx: &mut TxContext
    ) {
        let sender = tx_context::sender(ctx);
        
        let url = url::new_unsafe_from_bytes(string::into_bytes(url_str));

        let nft = JintolNFT {
            id: object::new(ctx),
            url,
            name,
            description
        };
        // 触发事件
        event::emit(JintolNFTEvent {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,
        });
        // 转给发起者
        transfer::public_transfer(nft, sender);
        
    }
}
