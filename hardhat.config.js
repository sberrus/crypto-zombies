require("dotenv").config();
require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
	const accounts = await hre.ethers.getSigners();

	for (const account of accounts) {
		console.log(account.address);
	}
});

//Variables de entorno para deploy en red ropsten
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;
const ROPSTEN_PRIVATE_KEY = process.env.ROPSTEN_PRIVATE_KEY;

module.exports = {
	solidity: "0.8.12",
	networks: {
		ropsten: {
			url: `https://eth-ropsten.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
			accounts: [`${ROPSTEN_PRIVATE_KEY}`],
		},
	},
};
