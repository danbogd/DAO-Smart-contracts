it('test 1', async function() {
	let firstOwner = accounts[1];
	let secondOwner = accounts[2];
	await contract.contractAddOwner(firstOwner);
	assert.equal(
		await contract.contractIsOwner(secondOwner),
		false
	);
	await contract.contractAddOwner(secondOwner, {from: firstOwner});
	assert.equal(
		await contract.contractIsOwner(secondOwner),
		true
	);
});
​
it('test 2', async function() {
	let firstOwner = accounts[1];
	let secondOwner = accounts[2];
	await contract.contractAddOwner(firstOwner);
	assert.isFalse(await contract.contractIsOwner(secondOwner));
	await contract.contractAddOwner(secondOwner, {from: firstOwner});
	assert.isTrue(await contract.contractIsOwner(secondOwner));
});
​
it('test 3', async function() {
	let firstOwner = accounts[1];
	let secondOwner = accounts[2];
	await contract.contractAddOwner(firstOwner);
	let contractIsOwner1 = await contract.contractIsOwner(secondOwner);
	await contract.contractAddOwner(secondOwner, {from: firstOwner});
	let contractIsOwner2 = await contract.contractIsOwner(secondOwner);
	assert.isFalse(contractIsOwner1);
	assert.isTrue(contractIsOwner2);
});
​
it('test 4', () => {
	var firstOwner = accounts[1];
	var secondOwner = accounts[2];
	return contract.contractAddOwner(firstOwner)
	.then(() => {
		return contract.contractAddOwner(secondOwner);
	}).then(() => {
		return contract.contractIsOwner.call(secondOwner);
	}).then((result) => {
		assert.isFalse(result);
		return contract.contractAddOwner(secondOwner, {from: firstOwner});
	}).then(() => {
		return contract.contractIsOwner.call(secondOwner);
	}).then((result) => {
		assert.isTrue(result);
	});
});
​
it('test 5', () => {
	var firstOwner = accounts[1];
	var secondOwner = accounts[2];
	return Promise.resolve()
	.then(() => contract.contractAddOwner(firstOwner))
	.then(() => contract.contractIsOwner(secondOwner))
	.then(() => assert.isFalse())
	.then(() => contract.contractAddOwner(secondOwner, {from: firstOwner}))
	.then(() => contract.contractIsOwner(secondOwner))
	.then(() => assert.isTrue())
});
Untitled 2KB JavaScript/JSON snippet