const Virus = artifacts.require('VirusFactory')
const {expectRevert} = require('@openzeppelin/test-helpers')
contract('VirusFactory', accounts =>{
    let virus
    const [alice, bob] = accounts
    beforeEach(async() =>{
        virus = await Virus.new()
    })

    it('should set name and symbol', async() => {
        assert(await virus.name() === 'CryptoVirus')
        assert(await virus.symbol() === 'Virus') 
    })

    it('should not mint level is 10', async() =>{
        await expectRevert( virus.mintVirus('virus1', 10, alice), 'The level parameter is not valid')
    })

    it('should mint when 0 < level < 10', async() =>{
        await virus.mintVirus('virus1', 3, alice)
        let virus1 = await virus.viruses(0)
        balance = await virus.balanceOf(alice)
        assert(virus1.name === 'virus1', 'the name of the token should be virus1')
        assert(virus1.level.toString() === '3','the level of the token should be 3')
        assert(await virus.virusToOwner(0) === alice,'the owner of the token should be alice')
        assert(await balance.toString() === '1', 'the balance of alice should be 1')
    })
})