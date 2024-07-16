#//# --------------------------------------------------------------------------------------
#//# Created using Sequence Diagram for Mac
#//# https://www.macsequencediagram.com
#//# https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12
#//# --------------------------------------------------------------------------------------
title "Chainlink VRF"

participant Developer as dev
participant Faucet as fau
participant Chainlink as cha
participant Wallet as wal
participant Contract as con


dev->fau: getLink()
fau->wal: authorise()
wal->fau: Authorisation
fau->wal: LINK
dev->cha: createSubscription()
cha->wal: authorise()
wal->cha: Authorisation
cha->cha: createSubscription()
cha->dev: SubscriptionId
dev->cha: fundSubscription( Subscription )
cha->wal: transfer( Subscription, LINK )
wal->cha: LINK
dev->con: deploy
con->dev: address
dev->cha: addConsumer( address )
dev->con: cast send <address> triggerVrfRequest()
con->cha: vrfCoordinator.requestRandomWords( Config )
cha->con: RequestId
con->con: markRequestUnfulfilled( RequestId )
cha-->con: fulfillRandomWordsRequest( RequestId )
con->con: markFulfilled( RequestId )

note over cha
"""
was not able to get programmatic subscribe to work, so,
ended up hard coding the SubscriptionId into config
"""
end note