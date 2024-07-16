#//# --------------------------------------------------------------------------------------
#//# Created using Sequence Diagram for Mac
#//# https://www.macsequencediagram.com
#//# https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12
#//# --------------------------------------------------------------------------------------
# https://www.websequencediagrams.com/

title "Many network config with mocks"

participant "Test.setup()" as test
participant DeployContract as script
participant ConfigFactory as cfg
participant Network as net


activate test

*->test: forge test

activate script

test->script: run()

activate cfg

script->cfg: new()
cfg->script: ConfigFactory
script->cfg: ConfigFactory.get()

alt [ wasCreated ]
	cfg->script: Config
else [ SEPOLIA ]
	cfg->cfg(>): new Config()
else [ ANVIL ]
	activate net
	cfg->net: new MockService()
	net->cfg: MockAddress
	cfg->cfg(>): new Config({ ..., MockAddress })
end

cfg->script: Config

deactivate cfg

script->net(>): new AnyContract( Config )
net->script: AnyContract


script->test: "struct Deployment{AnyContract, Config}
test->test(>): assign config = Config
test->test(>): assign testable = AnyContract

deactivate script

deactivate test
